//
//  ImageItemStorage.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/07.
//

import Foundation
import CoreData
import UIKit

extension ImageEntity {
    static var imageItemFetchRequest: NSFetchRequest<ImageEntity> {
        let request: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        return request
    }
}

struct ImageItem: Identifiable, Hashable {
    var id = UUID()
    var image: ImageEntity
    var real_image: UIImage
}

class ImageItemStorage: NSObject, ObservableObject {
//    @Published var imageItems: [ImageEntity] = []
//    {
//        willSet {
//            objectWillChange.send()
//        }
//    }
    @Published var imageItems: [ImageItem] = []
    private let imageController: NSFetchedResultsController<ImageEntity>
    private let managedObjectContext: NSManagedObjectContext
    
    init(_managedObjectContext: NSManagedObjectContext){
        managedObjectContext = _managedObjectContext
        imageController = NSFetchedResultsController(fetchRequest: ImageEntity.imageItemFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        imageController.delegate = self
        
        do {
            try imageController.performFetch()
            imageItems = (imageController.fetchedObjects ?? []).map({
                ImageItem(image: $0, real_image: UIImage(data: $0.data!)!)
            })
        } catch {
            print("")
        }
        
    }
    
    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(index: Int) {
//        for index in offsets {
//                let language = languages[index]
//        let del_item = ImageItems[
//                managedObjectContext.delete(language)
    }
}

extension ImageItemStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("add or change data")
        guard let _imageItems = controller.fetchedObjects as? [ImageEntity]
        else {return}
        
        imageItems = _imageItems.map({
            ImageItem(image: $0, real_image: UIImage(data: $0.data!)!)
        })
    }
}
