//
//  ContentView.swift
//  imgpicker
//
//  Created by 조영훈 on 2021/08/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 32) {
            imageView(for: viewModel.selectedImage)
            controlBar()
        }
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker, content: {
            ImagePicker(sourceType: viewModel.sourceType, completionHandler: viewModel.didSelectImage)
        })
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var selectedImage: UIImage?
        @Published var isPresentingImagePicker = false
        private(set) var sourceType: ImagePicker.SourceType = .camera
        
        func choosePhoto() {
            sourceType = .photoLibrary
            isPresentingImagePicker = true
        }
        
        func takePhoto() {
            sourceType = .camera
            isPresentingImagePicker = true
        }
        
        func didSelectImage(_ image: UIImage?) {
            selectedImage = image
            isPresentingImagePicker = false
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias SourceType = UIImagePickerController.SourceType

    let sourceType: SourceType
    let completionHandler: (UIImage?) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        viewController.sourceType = sourceType
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let completionHandler: (UIImage?) -> Void
        
        init(completionHandler: @escaping (UIImage?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image: UIImage? = {
                if let image = info[.editedImage] as? UIImage {
                    return image
                }
                return info[.originalImage] as? UIImage
            }()
            completionHandler(image)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completionHandler(nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
