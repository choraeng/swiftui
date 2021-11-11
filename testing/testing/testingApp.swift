//
//  testingApp.swift
//  testing
//
//  Created by 조영훈 on 2021/11/10.
//

import SwiftUI

@main
struct testingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
