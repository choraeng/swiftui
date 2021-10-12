//
//  BlogApp.swift
//  Blog
//
//  Created by 조영훈 on 2021/10/02.
//

import SwiftUI

@main
struct BlogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
