//
//  GridViewApp.swift
//  GridView
//
//  Created by 조영훈 on 2021/09/18.
//

import SwiftUI

@main
struct GridViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
