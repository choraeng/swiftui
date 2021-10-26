//
//  passwordView.swift
//  password
//
//  Created by 조영훈 on 2021/10/02.
//

import SwiftUI
import Foundation
import AlertToast


struct SetPasswordView: View {
    // view 관련
    var titles: [String] = ["Enter a passcode", "Verify your new passcode"]
    
    // 넘겨 받는
    @Binding var isPassword: Bool
    @Binding var isShowingSheet: Bool
    
    @State var temp_password: String = ""
    
    @State var passwordOption: PasswordOption = PasswordOption.digit_4
    @State var passwordOpetionSheet: Bool = false
    
    @State var isEnter: Bool = false
//    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    @ObservedObject var pwmodel: PasswordModel = PasswordModel()
    
    
    var body: some View {
        NavigationView {
            passwordView(pwmodel: pwmodel)
//            passwordView(
//
//            )
//            .toast(isPresenting: $pwmodel.done, duration: 1.0, tapToDismiss: true, alert: {
//                AlertToast(type: .complete(Color.green), title: "Done")
//            }, completion: {
//                pwmodel.done = false
//                isShowingSheet = false
//                isPassword = true
//            })
//            .accentColor(GlobalValue.navigation_color)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    if passwordOption == .string {
//                        if pwmodel.state == 0 {
//                            Button("Cancel") {
//                                isShowingSheet = false
//                            }
//                        }else {
//                            Button("Cancel") {
//                                pwmodel.state = 0
//                                pwmodel.password = ""
//                            }
//                        }
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    if passwordOption != .string {
//                        if pwmodel.state == 0 {
//                            Button("Cancel") {
//                                isShowingSheet = false
//                            }
//                        }else {
//                            Button("Cancel") {
//                                pwmodel.state = 0
//                                pwmodel.password = ""
//                            }
//                        }
//                    } else {
//                        if pwmodel.state == 0 {
//                            Button("Next") {
//                                temp_password = pwmodel.password
//                                pwmodel.password = ""
//                                pwmodel.state = 1
//                            }
//                            .disabled(pwmodel.password.count == 0)
//                        }else {
//                            Button("Done") {
//                                if temp_password == pwmodel.password {
//                                    pwmodel.done = true
//                                }else {
//                                    pwmodel.fail = true
//                                    pwmodel.password = ""
//                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                                    impactMed.impactOccurred()
//                                }
//                            }
//                        }
//                    }
//                }
//            }
        }
        
    }
}
