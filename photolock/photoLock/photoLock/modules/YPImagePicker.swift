//
//  YPImagePicker.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/03.
//

import SwiftUI
import YPImagePicker
import Photos

struct MediaPicker: UIViewControllerRepresentable {
  
    class Coordinator: NSObject, UINavigationControllerDelegate {
        let parent: MediaPicker
        
        init(_ parent: MediaPicker) {
            self.parent = parent
        }
    }

    typealias UIViewControllerType = YPImagePicker
    
    @EnvironmentObject var viewModel: CoreDataViewModel
    
    init(){
    }
    
    func makeUIViewController(context: Context) -> YPImagePicker {
        let config = setConfig()
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            for item in items {
                switch item {
                case .photo(let photo):
                    let height = photo.asset?.pixelHeight
                    let width = photo.asset?.pixelWidth
                    let date = photo.asset?.creationDate
                    
                    
                    let asset = PHAssetResource.assetResources(for: photo.asset!)[0]
                    let unsignedInt64 = asset.value(forKey: "fileSize") as? CLong
                    let size = Int64(bitPattern: UInt64(unsignedInt64!)) // byte
                    let name = asset.originalFilename
                    
//                    let data = photo.image.pngData()
                    let data = photo.image.jpegData(compressionQuality: 1)
                    
                    
//                    let _a = asset.assetLocalIdentifier
//                    print(_a)
//                    let _b = PHAsset.fetchAssets(withLocalIdentifiers: [_a], options: nil)
//                    print(_b[0])
                    
                    let newItem = viewModel.addImage(
                        name: name,
                        width: width ?? 0,
                        height: height ?? 0,
                        size: size,
                        date: date ?? Date(),
                        data: data ?? nil,
                        asset: asset.assetLocalIdentifier,
                        exifMeta: photo.exifMeta ?? [:]
                    )
                    viewModel.addItem(type: .image, item: newItem)
                case .video(let video):
                    print(video)
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: YPImagePicker, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func setConfig() -> YPImagePickerConfiguration {
        var config = YPImagePickerConfiguration()
       
        //Common
        config.isScrollToChangeModesEnabled = false // 이거는 풀로할꺼면 false
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = false
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = true
        config.shouldSaveNewPicturesToAlbum = false
//        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.library
        config.screens = [.library, .photo, .video]
        config.showsCrop = .none // 사진 찍고 자르는거
        config.targetImageSize = YPImageSize.original
//        config.overlayView = UIView()
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.hidesCancelButton = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.bottomMenuItemSelectedTextColour = UIColor.yellow
        config.bottomMenuItemUnSelectedTextColour = UIColor.red
        config.maxCameraZoomFactor = 5
        
        //library
//        config.library.mediaType = .photo
//        config.library.maxNumberOfItems = 1
//
//        config.wordings.libraryTitle = "Gallery"
//        config.library.skipSelectionsGallery = true
//        config.targetImageSize = .cappedTo(size: 1080)
        config.library.options = nil
        config.library.onlySquare = false
        config.library.isSquareByDefault = false
        config.library.minWidthForItem = nil
        config.library.mediaType = .photoAndVideo
        config.library.defaultMultipleSelection = false
        config.library.maxNumberOfItems = 10
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 3
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = false
        config.library.preselectedItems = nil
        config.library.itemOverlayType = .grid
        config.library.preSelectItemOnMultipleSelection = false
        
        config.video.fileType = .mov
        config.video.recordingTimeLimit = 60.0
        config.video.libraryTimeLimit = 60.0
        config.video.minimumTimeLimit = 3.0
        config.video.trimmerMaxDuration = 60.0
        config.video.trimmerMinDuration = 3.0
        
        config.gallery.hidesRemoveButton = false
        
        return config
    }
    
}
