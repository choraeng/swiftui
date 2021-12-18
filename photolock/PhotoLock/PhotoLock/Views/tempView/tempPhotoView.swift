////
////  tempPhotoView.swift
////  PhotoLock
////
////  Created by 조영훈 on 2021/12/14.
////
//
//import SwiftUI
//import PhotosUI
//
//struct PhotoPicker: UIViewControllerRepresentable {
//    typealias UIViewControllerType = PHPickerViewController
//    @Binding var selectedImg: [Image]
//    @Binding var isPresentPicker: Bool
//    
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        print("load picker")
//        
//        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//        //        config.filter = .vide
//        config.selectionLimit = 10
//        //        config.preferredAssetRepresentationMode = .compatible
//        
//        let controller = PHPickerViewController(configuration: config)
//        controller.delegate = context.coordinator
//        
//        return controller
//    }
//    
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//        
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(with: self, pickImage: $selectedImg)
//    }
//}
//
//extension PhotoPicker {
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var photoPicker: PhotoPicker
//        @Binding var pickImage: [Image]
//        
//        init(with photoPicker: PhotoPicker, pickImage: Binding<[Image]>){
//            self.photoPicker = photoPicker
//            _pickImage = pickImage
//        }
//        
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            if !results.isEmpty{
//                for i in results {
//                    let itemProvider = i.itemProvider
//                    
//                    if let assetId = i.assetIdentifier {
//                        let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
//                        
//                        let asset = PHAssetResource.assetResources(for: assetResults.firstObject!)
//                        
//                        print("-------------------")
//                        print("생성 날짜: \(String(describing: assetResults.firstObject!.creationDate))")
//                        print("위치   :\(String(describing: assetResults.firstObject!.location))")
//                        print("사이즈  :\(String(describing: assetResults.firstObject!.pixelWidth))*\(String(describing: assetResults.firstObject!.pixelHeight))")
//                        print("이름  :\(String(describing: asset.first!.originalFilename))")
//                        
//                        var sizeOnDisk: Int64 = 0
//                        var byte = ""
//                        if let resource = asset.first {
//                            let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
//                            sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
//                            byte = String(format: "%.2f", Double(sizeOnDisk) / (1024.0*1024.0))+" MB"
//                        }
//                        
//                        print("크기  :\(String(describing: byte))")
//                        print("")
//                        
//                    }
//                    
//                    if itemProvider.canLoadObject(ofClass: UIImage.self){
//                        itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
//                            (image, error) in
////                            print(image!)
//                            
//                            self.pickImage.append( Image(uiImage: image as! UIImage))
//                            //                    DispatchQueue.main.async {
//                            //                        self.pickImage = Image(uiImage: image!)
//                            //                    }
//                        })
//                        
//                    }
//                }
//                
//            }
//            photoPicker.isPresentPicker = false
//            //            pickImage = results[0]
//        }
//        
//        
//    }
//}
//
//
//struct tempPhotoView: View {
//    @State private var selectedImg: [Image] = []
//    @State private var isPresentPicker: Bool = false
//    
//    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
//    
//    var body: some View {
//        //        if selectedImg == nil {
//        VStack {
//            Button("picker") {
//                isPresentPicker.toggle()
//            }.sheet(isPresented: $isPresentPicker) {
//                PhotoPicker(selectedImg: $selectedImg, isPresentPicker: $isPresentPicker)
//            }
//            .padding()
//            //        } else {
//            //            selectedImg?
//            //                .resizable()
//            //                .scaledToFit()
//            //        }
//            ScrollView {
//                LazyVGrid(columns: gridItemLayout, spacing: 3) {
//                    ForEach((0..<selectedImg.count), id: \.self) { idx in
//                        Button {
//                            //                            selectedImg[idx].
//                        } label: {
//                            ZStack {
//                                Rectangle()
//                                    .fill(Color.gray)
//                                    .aspectRatio(1, contentMode: .fit)
//                                
//                                selectedImg[idx]
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .layoutPriority(-1)
//                                //                                .resizable()
//                                ////                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                //                                .aspectRatio(1, contentMode: .fill)
//                                //                                .clipped()
//                            }
//                            .clipped()
//                            
//                        }
//                        //                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
//                        //                        .aspectRatio(1, contentMode: .fill)
//                    }
//                }
//            }
//        }
//    }
//}
