//
//  ContentView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/10/30.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var appLockVM: AppLockModel
    
    var body: some View {
        //appLockModel 에서 그 인증중 변수를 추가하자
//        VerifyEmailView()
        
//        PartialSheetView()
        
        if appLockVM.isLock && !appLockVM.isAppUnlocked {
//            if appLockVM.isBio && !appLockVM.isUnloking{
                UnlockAppView()
//            }
        }else {
            NavigationView {
                NavigationLink {
                    tempPasswordView()
                } label: {
                    Text("password")
                }
    //            Text("asdfasdf")
    //                .foregroundColor(ColorPalette.primary.color)
    //                .padding()
    //
    //            Button("asdf"){
    //            }
    //                .buttonStyle(PrimaryButton())
            }
        }
    }

}
