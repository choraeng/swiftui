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


// date to korea date
// 2021년 10월 30일 토요일 13:00
func dateToStr(inputDate: Date?) -> String {
    if inputDate == nil {
        return ""
    }
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko")
    formatter.dateFormat = "YYYY년 M월 d일 eeee HH:mm"

    return formatter.string(from: inputDate!)
}

// file size
func fileSizeToStr(bytes: Int64) -> String {
    if bytes == 0 {
        return ""
    }
    let k: Double = 1024
    let sizes: [String] = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    
    let i = floor(log10(Double(bytes)) / log10(k))
    
    let ret = Double(bytes) / pow(k, i)
    
    return "\(String(format: "%.2f", ret)) \(sizes[Int(i)])"
}
