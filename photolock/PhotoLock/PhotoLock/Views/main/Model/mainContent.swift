//
//  content.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/18.
//

import Foundation
import SwiftUI

struct MainContent:Identifiable {
    var id = UUID()
//    var img: Image
    var height: Int = 0
    var width: Int = 0
    var name: String = ""
    var size: Double = 0.0
    var img: Data? = nil
    var tags: String = ""
    var memo: String = ""
    var isFavorite: Bool = false
}
