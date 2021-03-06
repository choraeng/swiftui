//
//  SwiftUI_EssentialsApp.swift
//  SwiftUI Essentials
//
//  Created by ์กฐ์ํ on 2021/07/19.
//

import SwiftUI

@main
struct SwiftUI_EssentialsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(modelData)
        }
    }
}
