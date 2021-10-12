//
//  AppLockView.swift
//  password
//
//  Created by 조영훈 on 2021/09/30.
//


import SwiftUI
import Combine

// MARK:- App Home View
struct AppHomeView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $appLockVM.isAppLockEnabled, label: {
                    Text("App Lock")
                })
                .onChange(of: appLockVM.isAppLockEnabled, perform: { value in
                    appLockVM.appLockStateChange(appLockState: value)
                })
            }
            .navigationTitle("App Home")
        }
    }
}

// MARK:- App Lock View
struct AppLockView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
   
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "lock.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.red)
            
            Text("App Locked")
                .font(.title)
                .foregroundColor(.red)
            
            Button("Open") {
                appLockVM.appLockValidation()
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red)
                
            )
            Spacer(minLength: 0)
        }.padding(.top, 50)
    }
}
