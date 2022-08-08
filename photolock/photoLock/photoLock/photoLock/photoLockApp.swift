//
//  photoLockApp.swift
//  photoLock
//
//  Created by user on 2022/08/08.
//

import SwiftUI

@main
struct photoLockApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
