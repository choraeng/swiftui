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
