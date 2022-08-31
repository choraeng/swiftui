//
//  perspective_ddApp.swift
//  perspective_dd
//
//  Created by 조영훈 on 2021/08/28.
//

import SwiftUI

@main
struct perspective_ddApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
