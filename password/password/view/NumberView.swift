//
//  NumberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/21.
//

import SwiftUI

struct NumberView: View {
    @State var _len: Int
    @ObservedObject var pwmodel: PasswordModel
    
    @State var temp_password: String = ""
    
    var body: some View {
        PincodeView(pwmodel:pwmodel, pwMaxLen:_len)
            .onChange(of: pwmodel.password) { _ in
                    if pwmodel.fail == true {
                        pwmodel.fail.toggle()
                    }
    
                    if pwmodel.password.count == _len {
                        if pwmodel.state == 0{
                            temp_password = pwmodel.password
                            pwmodel.password = ""
                            pwmodel.state = 1
                        }else {
                            if temp_password == pwmodel.password {
                                pwmodel.done = true
                            }else {
                                pwmodel.fail = true
    
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                            }
                        }
                    }
                }
    }
}

