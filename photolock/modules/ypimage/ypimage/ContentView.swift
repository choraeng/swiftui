//
//  ContentView.swift
//  ypimage
//
//  Created by 조영훈 on 2022/08/31.
//

import SwiftUI
//import YPImagePicker

struct ContentView: View {
    @State private var showMediaPicker: Bool = false
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            Button {
                showMediaPicker = true
            } label: {
                Text("Select Picture")
            }
            .fullScreenCover(isPresented: $showMediaPicker, onDismiss: {
                
            }) {
                MediaPicker(image: $image)
            }
            
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 100)
            }
        }
    }
}

//struct YPImagePickerView: UIViewControllerRepresentable
//{
//    func makeUIViewController(context: Context) -> YPImagePickerViewController {
//        let vc =  YPImagePickerViewController()
//        print("\nmakeUIViewController \(vc)")
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: YPImagePickerViewController, context: Context) {
//        print("updateUIViewController \(uiViewController)")
//    }
//
//    static func dismantleUIViewController(_ uiViewController: YPImagePickerViewController, coordinator: Self.Coordinator) {
//        print("dismantleUIViewController \(uiViewController)")
//    }
//
//}
//
//class YPImagePickerViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.green
//        print("viewDidLoad \(self)")
//        let picker = YPImagePicker()
//        picker.didFinishPicking { [unowned picker] items, _ in
//            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
//            }
//            picker.dismiss(animated: true, completion: nil)
//        }
//        present(picker, animated: true, completion: nil)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("viewWillDissapear \(self)")
//    }
//
//    deinit {
//        print("DEINIT \(self)")
//    }
//
//}
