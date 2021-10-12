//
//  passwordView.swift
//  password
//
//  Created by 조영훈 on 2021/10/02.
//

import SwiftUI
import Foundation
import AlertToast

struct passwordView: View {
//    @AppStorage("isPassword") var isPassword: Bool = UserDefaults.standard.bool(forKey: "isPassword")
    @Binding var isPassword: Bool
    @Environment(\.presentationMode) var presentationMode
    

    @State var passwordOption: Int = 0 // 0 -> 4자리, 1 -> 6자리, 2 -> string
    @State var passwordOpetionSheet: Bool = false
    
    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    // 테스트
    @State var save = false // 저장 유무
    
    var body: some View {
        VStack {
            if passwordOption == 0 || passwordOption == 1 {
                numberView(currentState: $currentState, pwMaxLen: 4 + 2*passwordOption,
                isPassword: $isPassword)
            }else {
                stringView(currentState: $currentState,
                           isPassword: $isPassword)
            }
            
            Spacer()
            
            if currentState == 0 {
                Button("Password Option"){
    //                pwInputType += 1
    //                pwInputType %= 3
                    passwordOpetionSheet.toggle()
                }
                .padding(.bottom, 24)
                .padding(.trailing, 123)
                .padding(.leading, 123)
                .actionSheet(isPresented: $passwordOpetionSheet) {
                    ActionSheet(title: Text("Password Option"), message: Text("select password type"),
                                buttons: [
                                    .default(Text("Custom Alphanumeric Code")){
                                        passwordOption = 2
                                    },
                                    .default(Text("4-Digit Numeric Code")){
                                        passwordOption = 0
                                    },
                                    .default(Text("6-Digit Numeric Code")){
                                        passwordOption = 1
                                    },
                                    .cancel(Text("Cancel"))])
                }
            }
        }
        .toast(isPresenting: $isPassword, duration: 1.0, tapToDismiss: true, alert: {
            AlertToast(type: .complete(Color.green), title: "Done")
        }, completion: {
            isPassword = true
            
            presentationMode.wrappedValue.dismiss()
        })
    }
}
