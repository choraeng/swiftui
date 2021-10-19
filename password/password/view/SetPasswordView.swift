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
                    PasswordNumberView(pwmodel:pwmodel, pwMaxLen:4)
                        .onChange(of: pwmodel.password) { _ in
                                if pwmodel.fail == true {
                                    pwmodel.fail.toggle()
                                }
                
                                if pwmodel.password.count == 4 {
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
                case .digit_6:
                    PasswordNumberView(pwmodel:pwmodel, pwMaxLen:6)
                        .onChange(of: pwmodel.password) { _ in
                                if pwmodel.fail == true {
                                    pwmodel.fail.toggle()
                                }
                
                                if pwmodel.password.count == 6 {
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
                case .string:
                    Text("asdf")
//                    PasswordStringView(isShowingSheet: $isShowingSheet,
//                               currentState: $currentState,
//                               password: $password,
//                               isPassword: $isPassword)
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
            }
            .toast(isPresenting: $pwmodel.done, duration: 1.0, tapToDismiss: true, alert: {
                AlertToast(type: .complete(Color.green), title: "Done")
            }, completion: {
                pwmodel.done = false
                isShowingSheet = false
                isPassword = true
            })
        }
        .accentColor(GlobalValue.navigation_color)
        
        //        .blur(radius: 0.5)
    }
}
