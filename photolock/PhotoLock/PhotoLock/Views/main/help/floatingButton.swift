//
//  contentAdd.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/17.
//

import SwiftUI
import PhotosUI

struct floatingButton: View {
    @EnvironmentObject var sheetStates: ViewStateModel
    
    @Binding var contents: [MainContent]// = []
    @State private var isPresentPicker: Bool = false
    @State private var isUploadSheeet = false
    
    @State var memoAddSheetShowing: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                
                Button {
                    isUploadSheeet.toggle()
                    //                    isPresentPicker.toggle()
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(ColorPalette.primary.color)
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                }
                .sheet(isPresented: $isPresentPicker) {
                    PhotoPicker(contents: $contents, isPresentPicker: $isPresentPicker, isUploadSheet: $isUploadSheeet)
                }
                
            }
        }
        .padding(16)
        .customBottomSheet(isPresented: $isUploadSheeet, title: "업로드") {
            AnyView(
                VStack(spacing: 10) {
                    Button {
                        print("ASdfasdf")
                    } label: {
                        HStack(spacing: 16) {
                            Image("camera")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            CustomText(text: "사진 촬영", size: 16, weight: .bold)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        //                    .padding(.horizontal, 6)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .buttonStyle(SheetButtonStyle())
                    
                    
                    
                    Button {
                        isPresentPicker.toggle()
                    } label: {
                        HStack(spacing: 16) {
                            Image("picture")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            CustomText(text: "사진 / 비디오", size: 16, weight: .bold)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        //                    .padding(.horizontal, 6)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .buttonStyle(SheetButtonStyle())
                    
                    Button {
                        withAnimation {
                            sheetStates.memoAddSheetShowing.toggle()
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image("memo")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            CustomText(text: "메모", size: 16, weight: .bold)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        //                    .padding(.horizontal, 6)
                        .padding(.vertical, 10)
                    }
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .buttonStyle(SheetButtonStyle())
                }
            )
            
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    @Binding var contents: [MainContent]
    @Binding var isPresentPicker: Bool
    @Binding var isUploadSheet: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        print("load picker")
        
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        //        config.filter = .vide
        config.selectionLimit = 10
        //        config.preferredAssetRepresentationMode = .compatible
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self, contents: $contents)
    }
}

extension PhotoPicker {
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var photoPicker: PhotoPicker
        //        @Binding var pickImage: [Image]
        @Binding var contents: [MainContent]
        
        init(with photoPicker: PhotoPicker, contents: Binding<[MainContent]>){
            self.photoPicker = photoPicker
            _contents = contents
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if !results.isEmpty{
                for i in results {
                    let itemProvider = i.itemProvider
                    
                    if let assetId = i.assetIdentifier {
                        let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                        
                        let asset = PHAssetResource.assetResources(for: assetResults.firstObject!)
                        
                        print("-------------------")
                        print("생성 날짜: \(String(describing: assetResults.firstObject!.creationDate))")
                        print("위치   :\(String(describing: assetResults.firstObject!.location))")
                        print("사이즈  :\(String(describing: assetResults.firstObject!.pixelWidth))*\(String(describing: assetResults.firstObject!.pixelHeight))")
                        print("이름  :\(String(describing: asset.first!.originalFilename))")
                        
                        var sizeOnDisk: Int64 = 0
                        var byte = ""
                        if let resource = asset.first {
                            let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
                            sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
                            byte = String(format: "%.2f", Double(sizeOnDisk) / (1024.0*1024.0))+" MB"
                        }
                        
                        print("크기  :\(String(describing: byte))")
                        print("")
                        
                    }
                    
                    if itemProvider.canLoadObject(ofClass: UIImage.self){
                        itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
                            (image, error) in
                            //                            print(image!)
                            
                            self.contents.append(MainContent(img: Image(uiImage: image as! UIImage)))
                            //                            self.pickImage.append( Image(uiImage: image as! UIImage))
                            //                    DispatchQueue.main.async {
                            //                        self.pickImage = Image(uiImage: image!)
                            //                    }
                        })
                        
                    }
                }
                
            }
            photoPicker.isPresentPicker = false
            photoPicker.isUploadSheet = false
            //            pickImage = results[0]
        }
        
        
    }
}
