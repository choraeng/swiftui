//
//  ItemViewModel.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/07.
//

import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
    let manager = PersistenceController.shared
//    @Published var items: [ItemEntity] = []
//    @Published
    @Published var currentItems: [ItemEntity] = []
    @Published var tags: [TagEntity] = []
    
    var currentAlbum: AlbumEntity?
    var albums: [AlbumEntity] = []
    
    init() {
//        getItems()
        getAllTags()
        
        getAlbums()
        if albums.isEmpty {
            addAlbum(isLock: false, name: "__main__", parent: nil)
            getAlbums()
        }
        
        currentAlbum = albums[0]
        getItems(album: currentAlbum!)
    }
    
    // MARK: - get
    func getItems(album: AlbumEntity){ //) -> [ItemEntity]{
//        var ret: [ItemEntity] = []
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ItemEntity.album), album)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        DispatchQueue.main.async {
            do {
                self.currentItems = try self.manager.context.fetch(request)
            } catch let error {
                print("Error fetching. \(error.localizedDescription)")
            }
        }
//        return ret
    }
    
    func getAlbums() {
        let request = NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        do {
            albums = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getAllTags() {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        do {
            tags = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
}

extension CoreDataViewModel{
    // MARK: - add
    func addItem(type: Int, title: String, note: String, isFavorite: Bool = false, image: ImageEntity?, video: VideoEntity?, memoE: MemoEntity?, album: AlbumEntity?) {
//        let newItem = genItem(type: type, image: image, video: video, memo: memo, album: album)
        let newItem = ItemEntity(context: manager.context)
        newItem.timestamp = Date()
        newItem.type = Int16(type)
        newItem.id = UUID()
        newItem.isFavorite = isFavorite
        newItem.title = title
        newItem.note = note
        
        // 타입구분하고 데이터 적용
        switch(type){
        case 0: // memo
            break
        case 1: // image
            newItem.image = image!
            break
        case 2: // video
            break
        default:
            break
        }
        
        // 앨범 위치 넣기
        if album != nil {
            newItem.album = album
        }
        
//        currentItems.append(newItem)
        save()
    }
    
    func addItem(item: ItemEntity){
//        currentItems.append(item)
        
        save()
    }
    
    func addItems(items: [ItemEntity]){
        currentItems.append(contentsOf: items)

        save()
    }
    
    func addAlbum(isLock: Bool, name: String, parent: AlbumEntity?) {
        let newItem = AlbumEntity(context: manager.context)
        newItem.timestamp = Date()
        newItem.name = name
        newItem.isLock = isLock
        newItem.parent = parent
        newItem.id = UUID()
        
        newItem.childs = nil
        newItem.items = nil
        
        save()
    }
    
    func addTag(color: Color, name: String) {
        let newItem = TagEntity(context: manager.context)
        newItem.id = UUID()
        newItem.name = name
        newItem.timestamp = Date()
//        newItem.color = setColor(color: color)
        
        newItem.r = color.components.red
        newItem.g = color.components.green
        newItem.b = color.components.blue
        newItem.a = color.components.opacity
        
        save()
    }
    
    func addTagIntoItem(item: ItemEntity, tag: TagEntity) {
//        item.addToTags(tag)
        if !(item.tags?.contains(tag) ?? false) {
            item.addToTags(tag)
            
            save()
        }
    }
    
    // MARK: - update
    func updateAlbumPosition() {
        getItems(album: currentAlbum!)
    }
    
    func updateNote(item: ItemEntity, newNote: String) {
        item.note = newNote
        save()
    }
    
    func updateFavorite(item: ItemEntity, newValue: Bool){
        item.isFavorite = newValue
        save()
    }
    
    // MARK: - delete
    func deleteTag(id: UUID) {
        
    }
    
    // MARK: - save
    func save() {
        manager.save()
        DispatchQueue.main.async {
            self.getItems(album: self.currentAlbum!)
            self.getAllTags()
        }
        
//        getAlbums()
//        getTags()
    }
}
    
extension CoreDataViewModel{
    // MARK: - Object generator
    func genItem(type: Int, title: String, note: String, isFavorite: Bool = false, image: ImageEntity?, video: VideoEntity?, memoE: MemoEntity?, album: AlbumEntity?) -> ItemEntity{
        let newItem = ItemEntity(context: manager.context)
        newItem.timestamp = Date()
        newItem.type = Int16(type)
        newItem.id = UUID()
        newItem.isFavorite = isFavorite
        newItem.title = title
        newItem.note = note
        
        // 타입구분하고 데이터 적용
        switch(type){
        case 0: // memo
            break
        case 1: // image
            newItem.image = image!
            break
        case 2: // video
            break
        default:
            break
        }
        
        // 앨범 위치 넣기
        if album != nil {
            newItem.album = album
        }
        
        return newItem
    }
    
    func genImage(size: Int = 0, createdAt: Date = Date(),
                  width: Int = 0, height: Int = 0,
                  data: Data = Data()) -> ImageEntity {
        let newItem = ImageEntity(context: manager.context)
        newItem.size = Int64(size)
        newItem.createdAt = createdAt
        newItem.width = Int64(width)
        newItem.height = Int64(height)
        newItem.data = data
        
        return newItem
    }
    
    // MARK: - etc
    func popAlbum() {
        if currentAlbum!.parent != nil {
            currentAlbum = currentAlbum!.parent!
            updateAlbumPosition()
        }
    }
    
    func pushAlbum(nextAlbum: AlbumEntity) {
        if currentAlbum!.childs != nil && currentAlbum!.childs!.contains(nextAlbum) {
            currentAlbum = nextAlbum
            updateAlbumPosition()
        }
    }
}


extension CoreDataViewModel {
    func getTagList(item: ItemEntity) -> [TagEntity] {
        return (item.tags?.array as? [TagEntity]) ?? []
    }
    
    func getTagList(idx: Int) -> [TagEntity] {
        return (currentItems[idx].tags?.array as? [TagEntity]) ?? []
    }
    
//    func getTagItem(item: ItemEntity, idx: Int) -> TagEntity? {
//        return getTagList(item: item)[idx]
//    }
}
