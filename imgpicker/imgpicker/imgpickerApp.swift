//
//  imgpickerApp.swift
//  imgpicker
//
//  Created by ์กฐ์ํ on 2021/08/31.
//

import SwiftUI

@main
struct imgpickerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
