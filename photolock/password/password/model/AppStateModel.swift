//
//  AppStateModel.swift
//  password
//
//  Created by ์กฐ์ํ on 2021/10/23.
//

import Foundation

class AppStateModel {
    var isLock: Bool = false
    var isBio: Bool = false
    var password: String = ""
    var passwordType: PasswordOption = .digit_4
}
