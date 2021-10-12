//
//  uikit_studyApp.swift
//  uikit_study
//
//  Created by 조영훈 on 2021/09/08.
//

import SwiftUI

@main
struct uikit_studyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
