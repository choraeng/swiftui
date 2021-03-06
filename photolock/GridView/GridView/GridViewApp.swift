//
//  GridViewApp.swift
//  GridView
//
//  Created by ์กฐ์ํ on 2021/09/18.
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
