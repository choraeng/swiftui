//
//  ContentView.swift
//  uikit_study
//
//  Created by ์กฐ์ํ on 2021/09/08.
//

import SwiftUI
import CoreData
import UIKit



struct ImagePickerController: UIViewControllerRepresentable {
 
    // ๐ SwiftUI ์์์ ๋ถ๋ชจ๋ทฐ์ @State property๋ถํฐ์ Binding
    @Binding var selectedImage: Image?
    @Binding var existSelectedImage: Bool
 
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
 
        return imagePickerController
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
 
    // ๐ซ 2. Cordinator ๋์.
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage, existSelectedImage: $existSelectedImage)
    }
 
}
 
extension ImagePickerController {
 
    // ๐ซ 1. Cordinator ๋ง๋ค๊ธฐ
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // ๐ SwiftUI ์์์ ๋ถ๋ชจ๋ทฐ์ @State property๋ถํฐ์ Binding
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
