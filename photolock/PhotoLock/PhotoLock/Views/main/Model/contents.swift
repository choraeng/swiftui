//
//  photoDataList.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/08.
//

import Foundation

//enum phototype: Int, Codable {
//    case image
//    case elbum
//    case favorite
//    case memo
//    case video
//}
//
//struct photoDataList {
////    var id = UUID()
////    var type: phototype
////    var favor: Bool = false
////    var data: AnyObject
//    var height: Int = 0
//    var width: Int = 0
//    var name: String = ""
//    var size: Double = 0.0
//    var img: Data? = nil
//    var tags: String = ""
//    var memo: String = ""
//    var isFavorite: Bool = false
//
//}
///
/// 여기는 각 데이터들 잠시 주고 받을 때 사용하는 클래스
///
///
struct ContentImage {
    var name: String = ""
    var size: Int64 = 0
    var height: Int = 0
    var width: Int = 0
    var isFavorite: Bool = false
    var data: Data? = nil
    var memo: String = ""
    var tags: [String] = []
    var createdAt: Date? = nil
}

struct ContentVideo {
    
}

struct ContentMemo {
    
}
