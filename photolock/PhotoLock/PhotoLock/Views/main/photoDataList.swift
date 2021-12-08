//
//  photoDataList.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/08.
//

import Foundation

enum phototype: Int, Codable {
    case image
    case elbum
    case favorite
    case memo
    case video
}

struct photoDataList {
//    var id = UUID()
    var type: phototype
    var favor: Bool = false
    var data: AnyObject
    
}
