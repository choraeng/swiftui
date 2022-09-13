//
//  ContentView.swift
//  photoLock
//
//  Created by user on 2022/08/08.
//

import SwiftUI
import FloatingButton
import SwiftUIBottomSheet

import ComposableArchitecture

struct ContentView: View {
    @State var camera: Bool = false
    @State private var image: UIImage?
    
    let store: Store<AppState, AppAction>
    
#if DEV
    @State var modal = false
    @State var isclick = false
    
    @EnvironmentObject var viewModel: CoreDataViewModel
    
    @State var isView = false
    
    @Namespace var ns
    @State var selectedImage: Int?
    
    @GestureState private var selectedImageOffset: CGSize = .zero
#endif
    
    var body: some View {
#if DEV
        WithViewStore(self.store) { viewStore in
            GeometryReader { geo in
                let width = geo.size.width // + geo.safeAreaInsets.leading + geo.safeAreaInsets.trailing
                let height = geo.size.height // + geo.safeAreaInsets.top + geo.safeAreaInsets.bottom
//                ZStack{
                    //                VStack {
                    //                    Button {
                    //                        viewStore.send(.addItemButtonTapped)
                    //                    } label: {
                    //                        Text("asdfasdfa")
                    //                    }
                    //                    .bottomSheet(isPresented: viewStore.binding(
                    //                        get: \.isItemAddSheetPresented,
                    //                        send: .addItemButtonTapped
                    //                    )) {
                    //                        VStack {
                    //                            Text("text")
                    //                            Text("text")
                    //                            Text("text")
                    //                            Text("text")
                    //                            Text("text")
                    //                            Text("text")
                    //                        }
                    //                    }
                    //
                    //                }
                    
                    VStack {
                        
                        ItemGridView(items: viewModel.itemEntities,
                                     selectedImage: $selectedImage,
                                     ns: ns,
                                     width: width,
                                     height: height
                        )
                            .zIndex(0)
                    }
                    
                    //                    if blur {
                    //                        VisualEffectView(uiVisualEffect: UIBlurEffect(style: config.darkMode ? .dark : .light))
                    //                            .edgesIgnoringSafeArea(.all)
                    ////                            .onTapGesture(perform: tapBackdrop)
                    //                            .transition(.opacity)
                    //                            .zIndex(2)
                    //                    }
                    if (selectedImage != nil && viewModel.itemEntities.count > 0) {
                        DetailHStack(images: viewModel.itemEntities.map {Image(uiImage: UIImage(data: $0.image!.data!)!.resize(width: width))},
                                     ids: viewModel.itemEntities.map { $0.id! },
                                     width: width,
                                     height: height,
                                     selectedImage: $selectedImage,
                                     ns: ns,
                                     selectedImageOffset: selectedImageOffset
                        )
                            .zIndex(2)
                    }
                    
                    
                    //                    if (selectedImage == nil) {
                    //                        FloatingButton(viewStore.binding(
                    //                            get: \.isMediaSheetPresented,
                    //                            send: .addMediaButtonTapped
                    //                        ))
                    //                            .zIndex(4)
                    //                            .fullScreenCover(isPresented: viewStore.binding(
                    //                                get: \.isMediaSheetPresented,
                    //                                send: .addMediaButtonTapped
                    //                            )) {
                    //
                    //                            } content: {
                    //                                MediaPicker()
                    //                            }
                    //                    }
                    
                }
            // }
        }
#else
        VStack {
            Button {
                camera.toggle()
            } label: {
                Text("카메라")
            }
            .fullScreenCover(isPresented: $camera) {
                
            } content: {
                MediaPicker()
            }
        }
#endif
        
    }
}

#if DEV

#endif
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
