//
//  ContentView.swift
//  uikit_study
//
//  Created by 조영훈 on 2021/09/08.
//

import SwiftUI
import CoreData
import UIKit



struct ImagePickerController: UIViewControllerRepresentable {
 
    // 👀 SwiftUI 에서의 부모뷰의 @State property부터의 Binding
    @Binding var selectedImage: Image?
    @Binding var existSelectedImage: Bool
 
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
 
        return imagePickerController
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
 
    // 💫 2. Cordinator 대입.
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage, existSelectedImage: $existSelectedImage)
    }
 
}
 
extension ImagePickerController {
 
    // 💫 1. Cordinator 만들기
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // 👀 SwiftUI 에서의 부모뷰의 @State property부터의 Binding
        @Binding var selectedImage: Image?
        @Binding var existSelectedImage: Bool
 
        init(selectedImage: Binding<Image?>, existSelectedImage: Binding<Bool>) {
            _selectedImage = selectedImage
            _existSelectedImage = existSelectedImage
        }
 
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedOriginalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
 
            selectedImage = Image(uiImage: selectedOriginalImage)
            existSelectedImage = true
        }
    }
 
}
 
struct ContentView: View {
 
    @State private var selectedImage: Image?
    @State private var existSelectedImage = false
 
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .scaledToFit()
            Button(action: didTapSelectedImageButton) {
                Text("Select Image")
            }
        }

        if selectedImage == nil {
            ImagePickerController(
                selectedImage: $selectedImage,
                existSelectedImage: $existSelectedImage
            )
        }
    }
 
    private func didTapSelectedImageButton() {
        selectedImage = nil
        existSelectedImage = false
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
