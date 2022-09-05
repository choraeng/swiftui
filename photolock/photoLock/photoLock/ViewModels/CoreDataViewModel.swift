//
//  CoreDataViewModel.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/05.
//

import CoreData
import PredicateKit

class CoreDataViewModel: ObservableObject {
    let managedObjectContext: NSManagedObjectContext
    let container: NSPersistentContainer
    
    @Published var itemEntities = [ItemEntity]()
    @Published var tagEntities = [TagEntity]()
    
    var currentAlbum = [AlbumEntity]()
    
    init (_managedObjectContext: NSManagedObjectContext) {
        managedObjectContext = _managedObjectContext
        
        container = NSPersistentCloudKitContainer(name: "photoLock")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA")
                print(error.localizedDescription)
            } else {
                print("SUCCESSFULLY LOAD CORE DATA")
            }
        }
        
//        print(currentAlbum)
        
        InitAlbum()
        
//        print(currentAlbum)
        
//        NSManagedObjectContext.fetch
        
        
//        fetchAllTags()
//
//        fetchAlbums()
//        if albums.isEmpty {
//            addAlbum(isLock: false, name: "__main__", parent: nil)
//            getAlbums()
//        }
//
//        currentAlbum = albums[0]
//        getItems(album: currentAlbum!)
    }
    
    
    func InitAlbum(){
        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(AlbumEntity.name), "__MAIN__")
        do {
            currentAlbum = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        
        print(currentAlbum)
        
        if currentAlbum == [] {
            addAlbum(isLock: false, name: "__MAIN__", parent: nil)
        }
    }
    
    
    func addAlbum(isLock: Bool, name: String, parent: AlbumEntity?) {
        let newItem = AlbumEntity(context: container.viewContext)
        newItem.timestamp = Date()
        newItem.name = name
        newItem.isLock = isLock
        newItem.parent = parent
        newItem.id = UUID()
        
        newItem.childs = nil
        newItem.items = nil
        
        save()
    }
    
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
    
//    // MARK: - fetch
//    func fetchItems(album: AlbumEntity){ //) -> [ItemEntity]{
////        var ret: [ItemEntity] = []
//        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
//        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ItemEntity.album), album)
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
//
//        DispatchQueue.main.async {
//            do {
//                self.currentItems = try self.manager.context.fetch(request)
//            } catch let error {
//                print("Error fetching. \(error.localizedDescription)")
//            }
//        }
////        return ret
//    }
//
//    func fetchAlbum() {
//        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
//
//        do {
//            albums = try manager.context.fetch(request)
//        } catch let error {
//            print("Error fetching. \(error.localizedDescription)")
//        }
//    }
//
//    func fetchAllTags() {
//        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
//
//        do {
//            tags = try manager.context.fetch(request)
//        } catch let error {
//            print("Error fetching. \(error.localizedDescription)")
//        }
//    }
//
//
//
//
//
//
//    func fetchFruits() {
//        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
//        do {
//            savedEntities = try container.viewContext.fetch(request)
//        } catch {
//            print("ERROR FETCHING CORE DATA")
//            print(error.localizedDescription)
//        }
//    }
//
//    func addFruit(name: String) {
//        let fruit = FruitEntity(context: container.viewContext)
//        fruit.name = name
//        saveData()
//    }
//
//    func deleteFruit(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let entity = savedEntities[index]
//        container.viewContext.delete(entity)
//        saveData()
//    }
//
//    func saveData() {
//        do {
//            try container.viewContext.save()
//            fetchFruits()
//        } catch {
//            print("ERROR SAVING CORE DATA")
//            print(error.localizedDescription)
//        }
//    }
//
//    func updateFruit(entity: FruitEntity, name: String) {
//        entity.name = name
//        saveData()
//    }
}

