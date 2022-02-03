//
//  KeyboardResponder.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/03.
//

import Foundation
import SwiftUI
import Combine
import UIKit


class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    @Published var currentKeyboard: Bool = false
    
    var _center: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        _center = center
        
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            withAnimation {
                currentHeight = keyboardSize.height
                currentKeyboard = true
//            }
        }
    }
    @objc func keyBoardWillHide(notification: Notification) {
//        withAnimation {c
            currentHeight = 0
            currentKeyboard = false
//        }
    }
    
    deinit{
        _center.removeObserver(self)
    }
}

//
//
///// Publisher to read keyboard changes.
//protocol KeyboardReadable {
//    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
//}
//
//extension KeyboardReadable {
//    var keyboardPublisher: AnyPublisher<Bool, Never> {
//        Publishers.Merge(
//            NotificationCenter.default
//                .publisher(for: UIApplication.keyboardWillShowNotification)
//                .map { _ in true },
//
//            NotificationCenter.default
//                .publisher(for: UIApplication.keyboardWillHideNotification)
//                .map { _ in false }
//        )
//            .eraseToAnyPublisher()
//    }
//}
//
//struct KeyboardAwareModifier: ViewModifier {
protocol KeyboardAwareModifier {
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> { get }
}

extension KeyboardAwareModifier {
//    @State private var keyboardHeight: CGFloat = 0

    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0)} //CGFloat(0) }
        ).eraseToAnyPublisher()
    }
}
//
//extension View {
//    func KeyboardAwarePadding() -> some View {
//        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
//    }
//}
//
/////////////////////////////////
//
//struct GeometryGetter: View {
//    @Binding var rect: CGRect
//
//    var body: some View {
//        GeometryReader { geometry in
//            Group { () -> AnyView in
//                DispatchQueue.main.async {
//                    self.rect = geometry.frame(in: .global)
//                }
//
//                return AnyView(Color.clear)
//            }
//        }
//    }
//}
//
//final class KeyboardGuardian: ObservableObject {
//    public var rects: Array<CGRect>
//    public var keyboardRect: CGRect = CGRect()
//
//    // keyboardWillShow notification may be posted repeatedly,
//    // this flag makes sure we only act once per keyboard appearance
//    public var keyboardIsHidden = true
//
//    @Published var slide: CGFloat = 0
//
//    var showField: Int = 0 {
//        didSet {
//            updateSlide()
//        }
//    }
//
//    init(textFieldCount: Int) {
//        self.rects = Array<CGRect>(repeating: CGRect(), count: textFieldCount)
//
//    }
//
//    func addObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
//    }
//
//    func removeObserver() {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//
//
//    @objc func keyBoardWillShow(notification: Notification) {
//        if keyboardIsHidden {
//            keyboardIsHidden = false
//            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
//                keyboardRect = rect
//                print("rect", keyboardRect)
//                updateSlide()
//            }
//        }
//    }
//
//    @objc func keyBoardDidHide(notification: Notification) {
//        keyboardIsHidden = true
//        print("hidden")
//        updateSlide()
//    }
//
//    func updateSlide() {
//        if keyboardIsHidden {
//            slide = 0
//            print("slide hidden", slide)
//        } else {
//            let tfRect = self.rects[self.showField]
//            let diff = keyboardRect.minY - tfRect.maxY
//
//            if diff > 0 {
//                slide += diff
//            } else {
//                slide += min(diff, 0)
//            }
//            print("slide", slide)
//        }
//    }
//}
//
