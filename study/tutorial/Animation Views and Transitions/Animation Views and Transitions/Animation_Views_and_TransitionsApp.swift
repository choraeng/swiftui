//
//  Animation_Views_and_TransitionsApp.swift
//  Animation Views and Transitions
//
//  Created by 조영훈 on 2021/08/08.
//

import SwiftUI

@main
struct Animation_Views_and_TransitionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
