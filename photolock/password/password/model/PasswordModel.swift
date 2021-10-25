//
//  PasswordModel.swift
//  password
//
//  Created by 조영훈 on 2021/10/18.
//

import Foundation

class PasswordModel: ObservableObject {
    
    @Published var state: Int = 0
    @Published var password: String = ""
    
    @Published var done: Bool = false
    @Published var Sheet: Bool = false
    @Published var fail: Bool = false
    
    func reset() {
        state = 0
        password = ""
        done = false
        Sheet = false
        fail = false
    }
}