//
//  PhotoLockApp.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/10/30.
//

import SwiftUI

@main
struct PhotoLockApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
