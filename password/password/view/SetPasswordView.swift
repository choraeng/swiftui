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
    @Binding var password: String
    
    enum PasswordOption {
        case digit_4
        case digit_6
        case string
    }
    
    
    @State var passwordOption: PasswordOption = PasswordOption.digit_4
    @State var passwordOpetionSheet: Bool = false
    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    @StateObject var pwmodel = PasswordModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(titles[currentState])
                    .font(.system(size: 21))
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 50)
                
                switch passwordOption {
                case .digit_4:
                    PasswordNumberView(isShowingSheet: $isShowingSheet,
                               currentState: $currentState,
                               password: $password,
                               isPassword: $isPassword,
                               pwmodel:pwmodel,
                               pwMaxLen: 4)
                case .digit_6:
                    PasswordNumberView(isShowingSheet: $isShowingSheet,
                               currentState: $currentState,
                               password: $password,
                               isPassword: $isPassword,
                               pwmodel:pwmodel,
                               pwMaxLen: 6)
                case .string:
                    PasswordStringView(isShowingSheet: $isShowingSheet,
                               currentState: $currentState,
                               password: $password,
                               isPassword: $isPassword)
                }
                
                Spacer()
                
                if currentState == 0 {
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
                                            password = ""
                                        },
                                        .default(Text("4-Digit Numeric Code")){
                                            passwordOption = .digit_4
                                            password = ""
                                        },
                                        .default(Text("6-Digit Numeric Code")){
                                            passwordOption = .digit_6
                                            password = ""
                                        },
                                        .cancel(Text("Cancel"))])
                    }
                }
            }
            .toast(isPresenting: $isPassword, duration: 1.0, tapToDismiss: true, alert: {
                AlertToast(type: .complete(Color.green), title: "Done")
            }, completion: {
                isPassword = false
                isShowingSheet = false
            })
        }
        .accentColor(GlobalValue.navigation_color)
        
        //        .blur(radius: 0.5)
    }
}
