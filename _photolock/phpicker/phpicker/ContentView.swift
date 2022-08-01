//
//  ContentView.swift
//  phpicker
//
//  Created by 조영훈 on 2021/09/16.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    @Binding var selectedImg: Image?
    @Binding var isPresentPicker: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        print("load picker")
        
        var config = PHPickerConfiguration()
//        config.filter = .vide
        config.selectionLimit = 2
//        config.preferredAssetRepresentationMode = .compatible
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self, pickImage: $selectedImg)
    }
}

extension PhotoPicker {
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var photoPicker: PhotoPicker
        @Binding var pickImage: Image?
        
        init(with photoPicker: PhotoPicker, pickImage: Binding<Image?>){
            self.photoPicker = photoPicker
            _pickImage = pickImage
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if !results.isEmpty{
                let itemProvider = results[0].itemProvider
                
                if itemProvider.canLoadObject(ofClass: UIImage.self){
                    itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
                        (image, error) in
                        print(image!)
                        self.pickImage = Image(uiImage: image as! UIImage)
    //                    DispatchQueue.main.async {
    //                        self.pickImage = Image(uiImage: image!)
    //                    }
                    })
                        
                }
            }
            photoPicker.isPresentPicker = false
//            pickImage = results[0]
        }
        
        
    }
}

struct ContentView: View {
    @State private var selectedImg: Image? = nil
    @State private var isPresentPicker: Bool = false
    
//    var configuration = PHP
    var body: some View {
        if selectedImg == nil {
            Button("picker") {
                isPresentPicker.toggle()
            }.sheet(isPresented: $isPresentPicker) {
                PhotoPicker(selectedImg: $selectedImg, isPresentPicker: $isPresentPicker)
            }
        } else {
            selectedImg?
                .resizable()
                .scaledToFit()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
