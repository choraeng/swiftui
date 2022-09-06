//
//  CoreDataViewModel.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/05.
//

import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
//    let managedObjectContext: NSManagedObjectContext
    let managedObjectContext =  PersistenceController.shared
    let container: NSPersistentContainer
    
    @Published var itemEntities = [ItemEntity]()
    @Published var tagEntities = [TagEntity]()
    
    var currentAlbum = [AlbumEntity]()
    
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
        if currentAlbum == [] {
            addAlbum(isLock: false, name: "__MAIN__", parent: nil)
        }
    }
    
    
    // MARK: - add
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

    // MARK: - get
    func getAlbums() {
        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(AlbumEntity.name), "__MAIN__")
        do {
            currentAlbum = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    
    func getItems() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ItemEntity.album), currentAlbum[0])
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
    func deleteAlbums() {
        for item in currentAlbum {
            container.viewContext.delete(item)
        }
        save()
    }
    
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

