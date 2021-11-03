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
    @State var APPSTATE: AppStateModel? = nil
    
    
    @State private var setPwSheet = false
    @State private var resetPwSheet = false
    
    @State private var setPassword = false
    
    @ObservedObject var pwmodel: PasswordModel = PasswordModel()
    
    init() {
        if let appstate = UserDefaults.standard.data(forKey: "AppState") {
            if let decoded = try? JSONDecoder().decode(AppStateModel.self, from: appstate) {
                _APPSTATE = State(initialValue: decoded)
            }
        }else {
            _APPSTATE = State(initialValue: AppStateModel())
        }
    }
    
    var body: some View {
        VStack {
            set_btn
            reset_btn
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
                APPSTATE?.passwordType = pwmodel.type
                APPSTATE?.isLock = true
                APPSTATE?.password = pwmodel.input_password

                if let encoded = try? JSONEncoder().encode(APPSTATE) {
                    UserDefaults.standard.set(encoded, forKey: "AppState")
                }
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
            pwmodel.type = APPSTATE!.passwordType
            pwmodel.target_password = APPSTATE!.password
            
            setPassword = false
            resetPwSheet = true
        }
        .sheet(isPresented: $resetPwSheet, onDismiss: {
            if setPassword {
//                AppPassword = pwmodel.input_password
                APPSTATE?.passwordType = pwmodel.type
                APPSTATE?.isLock = true
                APPSTATE?.password = pwmodel.input_password

                if let encoded = try? JSONEncoder().encode(APPSTATE) {
                    UserDefaults.standard.set(encoded, forKey: "AppState")
                }
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
