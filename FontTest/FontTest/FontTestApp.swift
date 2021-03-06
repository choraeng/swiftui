//
//  FontTestApp.swift
//  FontTest
//
//  Created by ์กฐ์ํ on 2021/11/27.
//

import SwiftUI

@main
struct FontTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
