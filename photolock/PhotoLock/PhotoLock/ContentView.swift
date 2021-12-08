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
    @State private var bottomSheetShown = false
    
    @State var sheetTest = false
    
    var body: some View {
        // 잠금 설정이 되어있고, 잠금 해제가 안되어 있다면
        //        if appLockVM.isLock && !appLockVM.isAppUnlocked {
        //                UnlockAppView()
        //        }else { // if 화면 잠금
        //            NavigationView {
        //                NavigationLink {
        //                    tempPasswordView()
        //                } label: {
        //                    Text("password")
        //                }
        //            } // navigationview
        //        } // if
        VStack {
            Button("partial test"){
                withAnimation(.easeInOut) {
                    sheetTest.toggle()
                }
            }
            
            Spacer()
        }
        .customBottomSheet(isPresented: $sheetTest, title: "main") {
            Text("Asdf")
                .frame(width: .infinity, height: 400)
        }
    }
    
    
}
