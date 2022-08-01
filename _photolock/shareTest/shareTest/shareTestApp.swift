//
//  shareTestApp.swift
//  shareTest
//
//  Created by 조영훈 on 2021/12/11.
//

import SwiftUI

@main
struct shareTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
