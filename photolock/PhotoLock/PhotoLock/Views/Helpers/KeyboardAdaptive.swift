//
//  KeyboardAdaptive.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/22.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State var bottomPadding: CGFloat = 0
    @State var bottomInset: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .animation(.easeOut(duration: 0.3))
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
                    }
                    .map { rect in
                        rect.height - bottomInset - 48//  - geometry.safeAreaInsets.bottom
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.bottomPadding))

                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.bottomPadding))
                })
        }
    }
}

extension View {
    func keyboardAdaptive(bottomInset: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(bottomInset: bottomInset))
    }
}
