//
//  shareTestApp.swift
//  shareTest
//
//  Created by ์กฐ์ํ on 2021/12/11.
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
