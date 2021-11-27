//
//  tempPasswordView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import SwiftUI
import Foundation


struct tempPasswordView: View {
    //    @AppStorage("AppPassword") var AppPassword = UserDefaults.standard.string(forKey: "password") ?? "" // 저장된 패스워드
    //    @AppStorage("AppState") var APPSTATE: AppStateModel = AppStateModel()
    @EnvironmentObject var appLockVM: AppLockModel
    @ObservedObject var pwmodel: PasswordModel = PasswordModel()
    
    @State private var setPwSheet = false
    @State private var resetPwSheet = false
    @State private var emailSheet = false
    
    @State private var setPassword = false
    
    
    var body: some View {
        VStack {
            set_btn
            reset_btn
            email_btn
        }
    }
}

extension tempPasswordView {
    var set_btn: some View {
        Button("set password") {
            setPassword = false
            setPwSheet = true
        }
        .sheet(isPresented: $setPwSheet, onDismiss: {
            print(setPassword)
            if setPassword {
                //                AppPassword = pwmodel.input_password
                appLockVM.setAppLock(pw: pwmodel.input_password, type: pwmodel.type)
            }
            pwmodel.reset()
        }) {
            SetPasswordView(isPassword: $setPassword,
                            isShowingSheet: $setPwSheet,
                            pwmodel: pwmodel,
                            toast_msg: "비밀번호 설정이 완료되었어요.")
        }
        .padding()
    }
}


extension tempPasswordView {
    var reset_btn: some View {
        Button("reset password") {
            //            pwmodel.target_password = AppPassword
            pwmodel.type = appLockVM.password_type
            pwmodel.target_password = appLockVM.password
            
            setPassword = false
            resetPwSheet = true
        }
        .sheet(isPresented: $resetPwSheet, onDismiss: {
            if setPassword {
                //                AppPassword = pwmodel.input_password
                appLockVM.setAppLock(pw: pwmodel.input_password, type: pwmodel.type)
            }
            pwmodel.reset()
        }) {
            ResetPasswordView(isPassword: $setPassword,
                              isShowingSheet: $resetPwSheet,
                              pwmodel: pwmodel)
        }
        .padding()
        
    }
}

extension tempPasswordView {
    var email_btn: some View {
        NavigationLink {
            VerifyEmailView()
        } label: {
            Text("email")
                .padding()
        }
//        Button("email password") {
//            //            pwmodel.target_password = AppPassword
//            emailSheet = true
//        }
//        .sheet(isPresented: $emailSheet, onDismiss: {
//
//        }) {
//
//        }
//        .padding()
        
    }
}
