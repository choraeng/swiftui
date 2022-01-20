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
    
    @State var mainviewFortest = false
    
    var body: some View {
        //         잠금 설정이 되어있고, 잠금 해제가 안되어 있다면
        if appLockVM.isLock && !appLockVM.isAppUnlocked {
            UnlockAppView()
        }else { // if 화면 잠금
            if mainviewFortest {
                MainView()
            } else {
                NavigationView {
                    VStack {
                        NavigationLink {
                            tempPasswordView()
                        } label: {
                            Text("password")
                        }
                        .padding()


//                        Button {
//                            withAnimation(.easeInOut) {
//                                sheetTest.toggle()
//                            }
//                        } label: {
//                            Text("partial test")
//                        }
//                        .padding()

                        Button("mainview") {
                            mainviewFortest.toggle()
                        }
                        .padding()

//                        NavigationLink {
//                            tempPhotoView()
//                        } label: {
//                            Text("photo pick and share")
//                        }
//                        .padding()

                    } // vstack
                    .navigationBarHidden(true)
                }// navigationview
                .customBottomSheet(isPresented: $sheetTest, title: "main") {
                    AnyView(
                    Text("Asdasdfasdff")
                        .foregroundColor(Color.red)
                        .frame(width: .infinity, height: 200)
                    )
                }
            } // if
        } // if
//        EmailHelpView()
    }
}
