//
//  Persistence.swift
//  photoLock
//
//  Created by 조영훈 on 2022/08/14.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "photoLock")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
//        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                #if DEV
                print("SUCCESSFULLY LOAD CORE DATA")
                #endif
            }
        })
    }
//    private static var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentCloudKitContainer(name: "CDOriEPS")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                 fatalError("Unable to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//
//    var context: NSManagedObjectContext {
//        return Self.persistentContainer.viewContext
//    }
}
