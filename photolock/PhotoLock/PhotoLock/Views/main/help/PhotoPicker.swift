//
//  phpicker.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/30.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    @Binding var isPresentPicker: Bool
    @Binding var isUploadSheet: Bool
    
    let completion: (_ type: Int,_ cImage: ContentImage?,_ cVideo: ContentVideo?,_ cMemo: ContentMemo?) ->Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        print("load picker")
        
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 10
        //        config.preferredAssetRepresentationMode = .compatible
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
}

extension PhotoPicker {
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        // for savinf core data
        @Environment(\.managedObjectContext) private var viewContext
        
        var photoPicker: PhotoPicker
        //        @Binding var pickImage: [Image]
        
        init(with photoPicker: PhotoPicker){
            self.photoPicker = photoPicker
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if !results.isEmpty{
                for i in results {
                    var height: Int = 0
                    var width: Int = 0
                    var name: String = ""
                    var size: Int64 = 0
                    var created: Date? = nil
                    var imageData: Data? = nil
                    var isPng: Bool = false
                    
                    if let assetId = i.assetIdentifier {
                        if let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject {
    //                        created = assetResults.creationDate!
    //                        print(created! ?? nil)
                            created = assetResults.creationDate ?? nil
                            height = assetResults.pixelHeight
                            width = assetResults.pixelWidth
                            
                            
                            let asset = PHAssetResource.assetResources(for: assetResults).first
                            
                            if let resource = asset {
                                let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
                                size = Int64(bitPattern: UInt64(unsignedInt64!)) // byte
    //                            byte = String(format: "%.2f", Double(sizeOnDisk) / (1024.0*1024.0))+" MB"
                                name = resource.originalFilename//String(asset!.originalFilename.split(separator: ".")[0])
                                if resource.uniformTypeIdentifier == "public.png"{
                                    isPng = true
                                    print(isPng)
                                }
                            }
                        }
                    }
                    
                    let itemProvider = i.itemProvider
                    
                    if itemProvider.canLoadObject(ofClass: UIImage.self){
                        itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
                            (image, error) in
                            //                            print(image!)
                            
//                            self.contents.append(MainContent(img: Image(uiImage: image as! UIImage)))
//                            self.contents.append(MainContent(height: height, width: width, name: name, size: size, img: (image! as! UIImage).jpegData(compressionQuality: 1.0), tags: "", memo: "", isFavorite: false))
                            if isPng{
                                imageData = (image! as! UIImage).pngData()
                            }else {
                                imageData = (image! as! UIImage).jpegData(compressionQuality: 1.0)
                            }
                            
                            self.photoPicker.completion(0,
                                                        ContentImage(name: name,
                                                                     size: size,
                                                                     height: height,
                                                                     width: width,
                                                                     isFavorite: false,
                                                                     data: imageData!,
                                                                     createdAt: created), nil, nil)
                            
                            //                            self.addItem(img: image as! UIImage)
                            //                            self.pickImage.append( Image(uiImage: image as! UIImage))
                            //                    DispatchQueue.main.async {
                            //                        self.pickImage = Image(uiImage: image!)
                            //                    }
                        })
                        
                    }
                }
                
            }
            photoPicker.isPresentPicker = false
            photoPicker.isUploadSheet = false
            //            pickImage = results[0]
        }
//        func addItem(img: UIImage) -> Void{
//            let data = img.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
//            let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
//
//            do {
//                try data!.write(to: url!) // data!.writeToURL(url, options: [])
//            } catch let e as NSError {
//                print("Error! \(e)");
//                return
//            }
//            ///// image
//            let record = CKRecord(recordType: "Image")
//            record.setValuesForKeys([
//                "createdAt": Date(),
//                "height": 1,
//                "width": 1,
//                "image": CKAsset(fileURL: url!),
//                "index": 1,
//                "isFavorite": 0,
//                "memo": "asdf",
//                "name": "Asdf",
//                "size": 123,
//                "tags": ["a","b","c"],
//            ])
//
//
//            ///// test
//            //            let record = CKRecord(recordType: "test")
//            //            record.setValuesForKeys([
//            //                "test1": "!23123",
//            //                "test2": CKAsset(fileURL: url!)
//            //            ])
//
//            let container = CKContainer.default()
//            let database = container.privateCloudDatabase
//
//            database.save(record) { record, error in
//                if let error = error {
//                    // Handle error.
//                    print(error)
//                    return
//                }
//                // Record saved successfully.
//                print("\(record!.recordID) save")
//                do {
//                    try FileManager.default.removeItem(at: url!)
//                } catch let e {
//                    print("Error deleting temp file: \(e)")
//                }
//            }
//        } // func additem
        
    }
}
