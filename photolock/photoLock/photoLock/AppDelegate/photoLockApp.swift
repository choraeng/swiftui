//
//  photoLockApp.swift
//  photoLock
//
//  Created by 조영훈 on 2022/08/14.
//

import ComposableArchitecture
import SwiftUI


@main
struct photoLockApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var items: CoreDataViewModel = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                          initialState: AppState(),
                          reducer: appReducer.debug(),
                          environment: AppEnvironment())
            )
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(items)
        }
    }
}
