//
//  CoreDataViewModel.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/05.
//

import CoreData
import SwiftUI

enum itemType: Int {
    case memo
    case image
    case video
}

class CoreDataViewModel: ObservableObject {
//    let managedObjectContext: NSManagedObjectContext
    let managedObjectContext =  PersistenceController.shared
    let container: NSPersistentContainer
    
    @Published var itemEntities = [ItemEntity]()
    @Published var tagEntities = [TagEntity]()
    
    var currentAlbum: AlbumEntity? = nil
    
    init() {
        container = NSPersistentCloudKitContainer(name: "photoLock")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA")
                print(error.localizedDescription)
            } else {
                print("SUCCESSFULLY LOAD CORE DATA")
            }
        }
                
        InitAlbum()
        getItems()
    }
    
    
    func InitAlbum(){
        getAlbums()
        if currentAlbum != nil {
            addAlbum(isLock: false, name: "__MAIN__") // , parent: nil)
        }
    }
    
    
    // MARK: - add
    func addAlbum(isLock: Bool, name: String) { //}, parent: AlbumEntity?) {
        let newItem = AlbumEntity(context: container.viewContext)
        newItem.timestamp = Date()
        newItem.name = name
        newItem.isLock = isLock
        newItem.parent = currentAlbum
        newItem.id = UUID()
        
        newItem.childs = nil
        newItem.items = nil
        
        save()
    }
    
    func addImage(width: Int, height: Int, size: Int, data: Data) -> ImageEntity {
        let newImage = ImageEntity(context: container.viewContext)
        newImage.createdAt = Date()
        newImage.size = Int64(size)
        newImage.width = Int16(width)
        newImage.height = Int16(height)
        newImage.data = data
        
        save()
        
        return newImage
    }
    
    
    
    func addItem(type: itemType, item: Any) {
        let newItem = ItemEntity(context: container.viewContext)
        newItem.id = UUID()
        newItem.isFavorite = false
        newItem.timestamp = Date()
        newItem.type = Int16(type.rawValue)
        
        switch(type) {
        case .memo:
            newItem.memo = item as? MemoEntity
            break
        case .image:
            newItem.image = item as? ImageEntity
            break
        case .video:
            newItem.video = item as? VideoEntity
            break
        }
        
        save()
    }

    // MARK: - get
    func getAlbums() {
        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(AlbumEntity.name), "__MAIN__")
        do {
            let albums = try container.viewContext.fetch(request)
            if albums != [] {
                currentAlbum = albums[0]
            }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    
    func getItems() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ItemEntity.album), currentAlbum!)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        DispatchQueue.main.async {
            do {
                self.itemEntities = try self.container.viewContext.fetch(request)
            } catch let error {
                print("Error fetching. \(error.localizedDescription)")
            }
        }
    }
    
    func getTags() {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        DispatchQueue.main.async {
            do {
                self.tagEntities = try self.container.viewContext.fetch(request)
            } catch let error {
                print("Error fetching. \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - delete
//    func deleteAlbums() {
//        for item in currentAlbum {
//            container.viewContext.delete(item)
//        }
//        save()
//    }
    
    // MARK: - save
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
    //            fetchFruits()
            } catch {
                print("ERROR SAVING CORE DATA")
                print(error.localizedDescription)
            }
        }
    }
}


// general use
extension CoreDataViewModel {
    
}

// TODO: - 우선 아이템 추가하는거 만들고,
