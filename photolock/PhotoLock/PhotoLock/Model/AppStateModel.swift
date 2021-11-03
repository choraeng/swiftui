//
//  AppStateModel.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import Foundation

enum PasswordOption: Int, Codable {
    case digit_4
    case digit_6
    case string
}

struct AppStateModel: Identifiable, Codable {
    var id = UUID()
    var isLock: Bool = false
    var isBio: Bool = false
    var password: String = ""
    var passwordType: PasswordOption = .digit_4
    
    init(){
        isLock = false
        isBio = false
        password = ""
        passwordType = .digit_4
    }
}
