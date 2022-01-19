//
//  Utils.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/11.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
#endif


