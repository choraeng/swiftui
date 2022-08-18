//
//  parkingFeeApp.swift
//  parkingFee
//
//  Created by 조영훈 on 2022/08/17.
//

import SwiftUI

@main
struct parkingFeeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
