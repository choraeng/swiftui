//
//  PhotoLockApp.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/29.
//

import SwiftUI

//@main
//struct PhotoLockApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

@main
struct PhotoLockApp: App {
    @StateObject var appLockVM = AppLockModel()
    @Environment(\.scenePhase) var scenePhase
//    @Environment(\.managedObjectContext) var managedObjectContext
    @State var blurRadius: CGFloat = 0
    
    
    let persistenceController = PersistenceController.shared
    
//    let persistenceManager: PersistenceController.
    
//    @StateObject var TagStorage: TagEntityStorage
//    @StateObject var AlbumStoage: AlbumEntityStorage
//    @StateObject var ItemStorage: ItemEntityStorage

    @StateObject var CoreDataModel: CoreDataViewModel = CoreDataViewModel()
//    @State var currentAlbum: AlbumEntity
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appLockVM)
                .environmentObject(CoreDataModel)
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
