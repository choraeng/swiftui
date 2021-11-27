//
//  PhotoLockApp.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/10/30.
//

import SwiftUI

@main
struct PhotoLockApp: App {
    @StateObject var appLockVM = AppLockModel()
    @Environment(\.scenePhase) var scenePhase
    @State var blurRadius: CGFloat = 0
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            ContentView()
                .environmentObject(appLockVM)
                .blur(radius: blurRadius)
                .onChange(of: scenePhase, perform: { value in
                    switch value {
                    case .active :
                        blurRadius = 0
                    case .background:
                        let a = 0
//                        appLockVM.isAppUnlocked = false
//                    case .inactive:
//                        blurRadius = 10
                    case .inactive:
                        blurRadius = 0
                    @unknown default:
                        print("unknown")
                    }
                })
        }
    }
}
