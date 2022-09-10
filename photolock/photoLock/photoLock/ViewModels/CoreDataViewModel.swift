//
//  CoreDataViewModel.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/05.
//

// 참고 링크
// https://velog.io/@j_aion/SwiftUI-CoreData-MVVM

import CoreData
import SwiftUI

enum itemType: Int {
    case memo
    case image
    case video
}

class CoreDataViewModel: ObservableObject {
//    let managedObjectContext: NSManagedObjectContext
//    let managedObjectContext =  PersistenceController.shared
    let container: NSPersistentContainer = PersistenceController.shared.container
    
    @Published var itemEntities = [ItemEntity]()
    @Published var tagEntities = [TagEntity]()
    
    var currentAlbum: AlbumEntity? = nil
    
    init() {
        #if DEV
//        deleteAlbums()
        deleteAllItems()
        
        #endif
        // set currentalbum as main album
        InitAlbum()
        
        // get items on currentalbum
        getItems()
    }
    
    
    func InitAlbum(){
        currentAlbum = getAlbum(name: "__MAIN__")
        if (currentAlbum == nil) {
            addAlbum(isLock: false, name: "__MAIN__") // , parent: nil)
            currentAlbum = getAlbum(name: "__MAIN__")
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
    
    func addImage(name: String, width: Int, height: Int, size: Int64, date: Date, data: Data?, asset: String, exifMeta: [String: Any]) -> ImageEntity {
        let newImage = ImageEntity(context: container.viewContext)
        newImage.createdAt = Date()
        newImage.size = Int64(size)
        newImage.width = Int16(width)
        newImage.height = Int16(height)
        newImage.data = data
        newImage.asset = asset
        newImage.exifMeta = exifMeta
        
        save()
        
        return newImage
    }
    
    
    
    func addItem(type: itemType, item: Any) {
        let newItem = ItemEntity(context: container.viewContext)
        newItem.id = UUID()
        newItem.isFavorite = false
        newItem.timestamp = Date()
        newItem.type = Int16(type.rawValue)
        newItem.album = currentAlbum
        
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
    func getAlbum(name: String) -> AlbumEntity? {
        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(AlbumEntity.name), name)
        do {
            let albums = try container.viewContext.fetch(request)
            if albums != [] {
//                currentAlbum = albums[0]
                return albums[0]
            }
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func getAllAlbum() -> [AlbumEntity] {
        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func getAllItems() -> [ItemEntity]{
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        do {
            return try self.container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
        return []
    }
    
    
    func getItems() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ItemEntity.album), currentAlbum!)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        DispatchQueue.main.async {
            do {
                self.itemEntities = try self.container.viewContext.fetch(request)
                print(self.itemEntities)
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
    func deleteAllAlbums() {
        for item in getAllAlbum() {
            #if DEV
            print("del " + item.description)
            #endif
            container.viewContext.delete(item)
        }
        save()
    }
    
    func deleteAllItems() {
        for item in getAllItems() {
            #if DEV
            print("del " + item.description)
            #endif
            container.viewContext.delete(item)
            
            let type = itemType(rawValue: Int(item.type))
            
            switch (type) {
            case .memo:
                container.viewContext.delete(item.memo!)
                break
            case .video:
                container.viewContext.delete(item.video!)
                break
            case .image:
                container.viewContext.delete(item.image!)
                break
            case .none:
                break
            }
            
            container.viewContext.delete(item)
        }
        save()
    }
    
    // MARK: - save
    func save() {
        if container.viewContext.hasChanges {
            #if DEV
            print("SAVE")
            #endif
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
