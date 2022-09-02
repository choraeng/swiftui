//
//  MediaPicker.swift
//  ypimage
//
//  Created by 조영훈 on 2022/08/31.
//

//import SwiftUI
//
//struct MediaPicker: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct MediaPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaPicker()
//    }
//}

import SwiftUI
import YPImagePicker

struct MediaPicker: UIViewControllerRepresentable {
  
    class Coordinator: NSObject, UINavigationControllerDelegate {
        let parent: MediaPicker
        
        init(_ parent: MediaPicker) {
            self.parent = parent
        }
    }

    typealias UIViewControllerType = YPImagePicker
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> YPImagePicker {
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
        
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.image = photo.image
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
    
}
