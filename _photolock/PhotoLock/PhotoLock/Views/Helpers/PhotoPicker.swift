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
    
    @EnvironmentObject var CoreDataModel: CoreDataViewModel
    
//    let completion: (_ item: ItemEntity) ->Void
    init(isPresentPicker: Binding<Bool>, isUploadSheet: Binding<Bool>) {
        _isPresentPicker = isPresentPicker
        _isUploadSheet = isUploadSheet
        
        checkAuth()
    }
    
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
    
    func checkAuth(){
        let readWriteStaus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        print(readWriteStaus)
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                // 아직 사용자가 앱의 접근을 결정하지 않았음
                print(1)
                break
            case .restricted:
                // 시스템이 앱의 접근을 제한
                print(2)
                break
            case .denied:
                // 사용자가 명시적으로 앱의 접근을 거무
                print(3)
                break
            case .authorized:
                // 사용자가 사진첩의 데이터에 접근을 허가
                print(4)
                break
            case .limited:
                // 사용자가 사진첩의 접근을 허가, 벗 제한된 사짐나
                print(5)
                break
            @unknown default:
                fatalError()
            }
        }
    }
}

extension PhotoPicker {
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
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
                                name = resource.originalFilename //String(asset!.originalFilename.split(separator: ".")[0])
                                if resource.uniformTypeIdentifier == "public.png"{
                                    isPng = true
                                }
                            }
                        }
                    }
                    
                    let itemProvider = i.itemProvider
                    
                    
                    if itemProvider.canLoadObject(ofClass: UIImage.self){
                        itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
                            (image, error) in
                            if isPng{
                                imageData = (image! as! UIImage).pngData()
                            }else {
                                imageData = (image! as! UIImage).jpegData(compressionQuality: 1.0)
                            }
                            
                            // MARK: - add item
//                            self.photoPicker.completion(
                            DispatchQueue.main.async {
                                self.photoPicker.CoreDataModel.addItem(
                                type: 1,
                                title: name,
                                note: "",
                                isFavorite: false,
                                image: self.photoPicker.CoreDataModel.genImage(
                                    size: Int(size), createdAt: created ?? Date(), width: width, height: height, data: imageData!),
                                video: nil,
                                memoE: nil,
                                album: self.photoPicker.CoreDataModel.currentAlbum)
                            }
                        })
                        
                    } // if uiimage
                } // for result
//                photoPicker.isPresentPicker = false
//                photoPicker.isUploadSheet = false
            }// if result not empty
            photoPicker.isPresentPicker = false
            photoPicker.isUploadSheet = false
        }
    }
}
