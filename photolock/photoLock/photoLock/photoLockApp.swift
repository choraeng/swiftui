//
//  photoLockApp.swift
//  photoLock
//
//  Created by 조영훈 on 2022/08/02.
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
