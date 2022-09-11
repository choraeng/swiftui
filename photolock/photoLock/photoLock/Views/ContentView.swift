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
    @State var selectedImage: UUID?
#endif
    
    var body: some View {
#if DEV
        WithViewStore(self.store) { viewStore in
            GeometryReader { geo in
                ZStack{
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
                    if (selectedImage == nil){
                        ItemGridView(items: viewModel.itemEntities,
                                     selectedImage: $selectedImage,
                                     ns: ns)
                    }else {
                        //                    PhotoView(image: UIImage(data: viewModel.itemEntities[0].image?.data ?? Data()) ?? UIImage())
                        DetailHStack(selectedImage: $selectedImage,
                                     ns: ns)
//                                     width: geo.size.width, height: geo.size.height
                    }
                    
                    
                    FloatingButton(viewStore.binding(
                        get: \.isMediaSheetPresented,
                        send: .addMediaButtonTapped
                    ))
                        .fullScreenCover(isPresented: viewStore.binding(
                            get: \.isMediaSheetPresented,
                            send: .addMediaButtonTapped
                        )) {
                            
                        } content: {
                            MediaPicker()
                        }
                }
            }
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
