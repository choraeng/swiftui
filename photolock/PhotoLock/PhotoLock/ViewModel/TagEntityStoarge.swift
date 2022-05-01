////
////  TagEntityStoarge.swift
////  PhotoLock
////
////  Created by 조영훈 on 2022/02/26.
////
//
//import Foundation
//import CoreData
//import UIKit
//import SwiftUI
//
//extension TagEntity {
//    static var ItemFetchRequest: NSFetchRequest<TagEntity> {
//        let request: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
//        request.predicate = nil
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
//        
//        return request
//    }
//}
//
////struct Tag: Identifiable, Hashable {
////    var id = UUID()
////    var tag: ImageEntity
////}
//
//class TagEntityStorage: NSObject, ObservableObject {
////    @Published var imageItems: [ImageEntity] = []
////    {
////        willSet {
////            objectWillChange.send()
////        }
////    }
//    @Published var tags: [TagEntity] = []
//    private let fetchController: NSFetchedResultsController<TagEntity>
//    private let managedObjectContext: NSManagedObjectContext
//    
//    init(_managedObjectContext: NSManagedObjectContext){
//        managedObjectContext = _managedObjectContext
//        fetchController = NSFetchedResultsController(fetchRequest: TagEntity.ItemFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//        
//        super.init()
//        
//        fetchController.delegate = self
//        
//        do {
//            try fetchController.performFetch()
//            tags = fetchController.fetchedObjects ?? []
////              .map({
////                ImageItem(image: $0, real_image: UIImage(data: $0.data!)!)
////            })
//        } catch {
//            print("")
//        }
//        
//    }
//    
//    func save() -> Bool {
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//                return true
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//        return false
//    }
//    
//    func delete(index: Int) {
////        for index in offsets {
////                let language = languages[index]
////        let del_item = ImageItems[
////                managedObjectContext.delete(language)
//    }
//    
//    func add(color: Color, name: String) -> UUID? {
//        let newItem = TagEntity(context: managedObjectContext)
//        
//        let id = UUID()
//        newItem.id = id
//        newItem.timestamp = Date()
//        newItem.color = setColor(color: color)
//        newItem.name = name
//        
//        let result = self.save()
//        if result {
//            return id
//        }
//        return nil
//    }
//}
//
//extension TagEntityStorage: NSFetchedResultsControllerDelegate {
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        print("add or change data")
//        guard let _items = controller.fetchedObjects as? [TagEntity]
//        else {return}
//        tags = _items
////        tags = _items.map({
////            ImageItem(image: $0, real_image: UIImage(data: $0.data!)!)
////        })
//    }
//}
