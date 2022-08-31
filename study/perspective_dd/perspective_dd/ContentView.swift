//
//  ContentView.swift
//  perspective_dd
//
//  Created by 조영훈 on 2021/08/28.
//

import SwiftUI
import CoreData

import DDPerspectiveTransform

struct PerspectiveController: UIViewControllerRepresentable{
    typealias UIViewControllerType = DDPerspectiveTransformViewController
    @Binding var selectedImage: Image?
    @Binding var existSElectedImage: Bool
    @Binding var isCrop: Bool
    
    
    func makeUIViewController(context: Context) -> DDPerspectiveTransformViewController {
        let perspectiveContoller = DDPerspectiveTransformViewController()
        perspectiveContoller.delegate = context.coordinator
//        perspectiveContoller.image =  // UIImage(named: "lakemcdonald")
        selectedImage.
        
        perspectiveContoller.pointSize = CGSize(width: 50.0, height: 50.0)
        perspectiveContoller.boxLineWidth = CGFloat(1.0)
//        perspectiveContoller.padding = CGFloat(0.0)
        
        print("init view controller")
        return perspectiveContoller
    }
    
    func updateUIViewController(_ uiViewController: DDPerspectiveTransformViewController, context: Context) {
//        print($isCrop)
        if(self.isCrop){
//            perspectiveContoller.cropAction()
            uiViewController.cropAction()
        }
    }
    
    func makeCoordinator() ->Coordinator {
        Coordinator(selectedImage: $selectedImage, existSelectedImage: $existSElectedImage)
            
    }
}

extension PerspectiveController{
    final class Coordinator: NSObject, UINavigationControllerDelegate,
                             DDPerspectiveTransformProtocol {
        @Binding var selectedImage: Image?
        @Binding var existSElectedImage: Bool
        
        init(selectedImage: Binding<Image?>, existSelectedImage: Binding<Bool>) {
            _selectedImage = selectedImage
            _existSElectedImage = existSelectedImage
        }
        
        func perspectiveTransformingDidFinish(controller: DDPerspectiveTransformViewController, croppedImage: UIImage) {
            
            // 이게 완료 되었을때
            selectedImage = Image(uiImage: croppedImage)
//            selectedImage = Image(uiImage: UIImage(named: "stmarylake")!)
        }
        
        func perspectiveTransformingDidCancel(controller: DDPerspectiveTransformViewController) {
            
        }
        
        
    }
}


extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


struct ContentView: View {
    @State private var selectedImage: Image?
    @State private var existSelectedImage = false
    @State private var isCrop: Bool = false
    
    
    var body: some View {
        NavigationView {
//            VStack{
//                Image(uiImage: UIImage(named: "lakemcdonald")!)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 250, height: 250, alignment: .center)
//                Image("lakemcdonald")
//            }
            if selectedImage == nil {
                VStack {
                     PerspectiveController(
                        selectedImage: $selectedImage,
                        existSElectedImage: $existSelectedImage,
                        isCrop: $isCrop
                    )
                    Spacer()
                    Button(action: corp) {
                        Text("Crop")
                    }
                }
                .padding()
            }else{
                VStack {
                    selectedImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250, alignment: .center)
                    Spacer()
                    Button(action: didTapSelectedImageButton) {
                        Text("Select Image")
                    }

                }
                .padding()
            }
        }
    }
    
    private func corp() {
        isCrop = true
    }
    
    private func didTapSelectedImageButton() {
        selectedImage = nil
        existSelectedImage = false
        isCrop = false
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



