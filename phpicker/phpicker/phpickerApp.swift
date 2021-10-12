//
//  phpickerApp.swift
//  phpicker
//
//  Created by 조영훈 on 2021/09/16.
//

import SwiftUI

@main
struct phpickerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
