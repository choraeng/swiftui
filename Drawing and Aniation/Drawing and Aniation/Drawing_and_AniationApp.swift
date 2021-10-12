//
//  Drawing_and_AniationApp.swift
//  Drawing and Aniation
//
//  Created by 조영훈 on 2021/08/07.
//

import SwiftUI

@main
struct Drawing_and_AniationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
