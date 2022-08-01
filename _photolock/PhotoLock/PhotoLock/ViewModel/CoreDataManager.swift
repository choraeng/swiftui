//
//  CoreDataManager.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/12.
//

import CoreData

//class CoreDataManager {
//    static var instance = CoreDataManager() // singleton
//    let container: NSPersistentCloudKitContainer
//    var context: NSManagedObjectContext
//    
////    var managedObjectContext: NSManagedObjectContext
//    
//    init(inMemory: Bool = false) {
////        container = NSPersistentContainer(name: "PhotoLock")
//        container = NSPersistentCloudKitContainer(name: "PhotoLock")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores { (description, error) in
//            if let error = error {
//                print("Error loading core data. \(error)")
//            } else {
//                print("Successfully loaded core data.")
//            }
//        }
//        context = container.viewContext
//    }
//    
//    func save() {
//        do {
//            try context.save()
//            print("Successfully save.")
//        } catch let error {
//            print("Error saving. \(error)")
//        }
//    }
//}
