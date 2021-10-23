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
    
    enum PasswordOption {
        case digit_4
        case digit_6
        case string
    }
    
    
    @State var passwordOption: PasswordOption = PasswordOption.digit_4
    @State var passwordOpetionSheet: Bool = false
    
    @State var isEnter: Bool = false
//    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    @ObservedObject var pwmodel: PasswordModel = PasswordModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(titles[pwmodel.state])
                    .font(.system(size: 21))
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 50)
                
                switch passwordOption {
                case .digit_4:
                    NumberView(_len: 4, pwmodel: pwmodel)
                case .digit_6:
                    NumberView(_len: 6, pwmodel: pwmodel)
                case .string:
                    StringView(pwmodel:pwmodel, commit: $isEnter, pwMaxLen:20)
                        .onChange(of: isEnter) { newValue in
                            if pwmodel.state == 0 {
                                temp_password = pwmodel.password
                                pwmodel.password = ""
                                pwmodel.state = 1
                            } else {
                                if temp_password == pwmodel.password {
                                    pwmodel.done = true
                                }else {
                                    pwmodel.fail = true
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                }
                            }
                        }
//                        .onChange(of: pwmodel.password) { newValue in
//                        }
                }
                
                Spacer()
                
                if pwmodel.state == 0 {
                    Button("Password Option"){
                        passwordOpetionSheet.toggle()
                    }
                    .foregroundColor(GlobalValue.option_color)
                    .padding(.bottom, 24)
                    .padding([.trailing, .leading], 123)
                    .actionSheet(isPresented: $passwordOpetionSheet) {
                        ActionSheet(title: Text("Password Option"), message: Text("select password type"),
                                    buttons: [
                                        .default(Text("Custom Alphanumeric Code")){
                                            passwordOption = .string
                                            pwmodel.reset()
                                            temp_password = ""
                                        },
                                        .default(Text("4-Digit Numeric Code")){
                                            passwordOption = .digit_4
                                            pwmodel.reset()
                                            temp_password = ""
                                        },
                                        .default(Text("6-Digit Numeric Code")){
                                            passwordOption = .digit_6
                                            pwmodel.reset()
                                            temp_password = ""
                                        },
                                        .cancel(Text("Cancel"))])
                    }
                }
                if passwordOption != .string {
                    KeyboardView(password: $pwmodel.password)
                }
            }
            .toast(isPresenting: $pwmodel.done, duration: 1.0, tapToDismiss: true, alert: {
                AlertToast(type: .complete(Color.green), title: "Done")
            }, completion: {
                pwmodel.done = false
                isShowingSheet = false
                isPassword = true
            })
            .accentColor(GlobalValue.navigation_color)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if passwordOption == .string {
                        if pwmodel.state == 0 {
                            Button("Cancel") {
                                isShowingSheet = false
                            }
                        }else {
                            Button("Cancel") {
                                pwmodel.state = 0
                                pwmodel.password = ""
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if passwordOption != .string {
                        if pwmodel.state == 0 {
                            Button("Cancel") {
                                isShowingSheet = false
                            }
                        }else {
                            Button("Cancel") {
                                pwmodel.state = 0
                                pwmodel.password = ""
                            }
                        }
                    } else {
                        if pwmodel.state == 0 {
                            Button("Next") {
                                temp_password = pwmodel.password
                                pwmodel.password = ""
                                pwmodel.state = 1
                            }
                            .disabled(pwmodel.password.count == 0)
                        }else {
                            Button("Done") {
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
        }
        
    }
}
