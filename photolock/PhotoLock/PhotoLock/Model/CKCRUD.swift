////
////  CKCRUD.swift
////  PhotoLock
////
////  Created by 조영훈 on 2022/01/23.
////
//
//import Foundation
//import CloudKit
//
//
//
//func save() {
//    // set image
//    let data = img.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
//    let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
//    
//    do {
//        try data!.write(to: url!) // data!.writeToURL(url, options: [])
//    } catch let e as NSError {
//        print("Error! \(e)");
//        return
//    }
//    
//    // set record
//    let record = CKRecord(recordType: "test")
//    record.setValuesForKeys([
//        "test1": "!23123",
//        "test2": CKAsset(fileURL: url!)
//    ])
//    
//    // save
//    let container = CKContainer.default()
//    let database = container.privateCloudDatabase
//    
//    database.save(record) { record, error in
//        if let error = error {
//            // Handle error.
//            print(error)
//            return
//        }
//        // Record saved successfully.
//        print("save")
//        do {
//            try FileManager.default.removeItem(at: url!)
//        } catch let e {
//            print("Error deleting temp file: \(e)")
//        }
//        
//    }
//}
//
//func delete() {
//    let container = CKContainer.default()
//    let db = container.privateCloudDatabase
//    
////    db.delete(withRecordID: <#T##CKRecord.ID#>, completionHandler: <#T##(CKRecord.ID?, Error?) -> Void#>)
//}
//
//func search() {
//    let container = CKContainer.default()
//    let db = container.privateCloudDatabase
//    //
//    //        let record = CKRecord(recordType: "test")
//    //        db.
//    
//    let argu = "asdf"
//    let pred = NSPredicate(format: "memo == %@", argu)
////        let argu = 1 //"49113628-D7E9-48F1-8EC8-EAE05EDCDF54"
////        let pred = NSPredicate(format: "%K = %@", "___etag", argu)
//    
//    //        let sort = NSSortDescriptor(key: "image", ascending: true)
//    let query = CKQuery(recordType: "Image", predicate: pred)
//    //        query.sortDescriptors = [sort]
//    
//    
//    //        let pred = NSPredicate(value: true)
//    //        let sort = NSSortDescriptor(key: "test1", ascending: false)
//    //        let query = CKQuery(recordType: "test", predicate: pred)
//    //        query.sortDescriptors = [sort]
//    
//    let operation = CKQueryOperation(query: query)
//    operation.desiredKeys = ["image"]
//    operation.resultsLimit = 10
//    
//    
//    operation.recordFetchedBlock = { record in
//        print(record.recordID.recordName)
//        if record["image"] != nil {
//            let temp = record["image"] as? CKAsset
//            //                print(temp!)
//            let assetsData = NSData(contentsOf: (temp?.fileURL!)!)
////                _img.append(Image(uiImage: UIImage(data: assetsData! as Data)!))
//        }
//    }
//    
//    operation.queryCompletionBlock = { (cursor, error) in
//        DispatchQueue.main.async {
//            if let error = error {
//                //                            completion(.failure(error))
//                print(error)
//            } else {
//                print("done")
//                //                            completion(.success(newShoe))
//            }
//        }
//    }
//    
//    db.add(operation)
//}
//
//func modify() {
//    // 검색 후에
//    // 다시 저장하기
//}
