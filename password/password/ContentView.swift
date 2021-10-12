//
//  ContentView.swift
//  password
//
//  Created by 조영훈 on 2021/09/26.
//

import SwiftUI
import Foundation


struct ContentView: View {
    @AppStorage("isPassword") var isPassword: Bool = UserDefaults.standard.bool(forKey: "isPassword")
    
    @EnvironmentObject var appLockVM: AppLockViewModel
    
    @State private var isShowingSheet = false
    
    @State var ispwInputTypeDisable = false // 패스워드 입력 설정 액션시트
    
    var body: some View {
//                   ㅌ1 ZStack {
//                        // Show HomeView app lock is not enabled or app is in unlocked state
//                        if !appLockVM.isAppLockEnabled || appLockVM.isAppUnLocked {
//                            AppHomeView()
//                        } else {
//                            AppLockView()
//                        }
//                    }
//                    .onAppear {
//                        // if 'isAppLockEnabled' value true, then immediately do the app lock validation
//                        if appLockVM.isAppLockEnabled {
//                            appLockVM.appLockValidation()
//                        }
//                    }
        Button ("set Password") {
            isPassword = false
            isShowingSheet.toggle()
//            passwordView(nowPosition: $nowPosition)
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
            passwordView(isPassword: $isPassword)
        }
    }
    
    func didDismiss() {
        print(isPassword)
        appLockVM.appLockStateChange(appLockState: true)
    }
}
