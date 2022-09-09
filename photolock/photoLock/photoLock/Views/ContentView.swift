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
#if DEV
//import test



#endif

struct ContentView: View {
    @State var camera: Bool = false
    @State private var image: UIImage?
    
    let store: Store<AppState, AppAction>
    
#if DEV
    @State var modal = false
    @State var isclick = false
    
    @EnvironmentObject var items: CoreDataViewModel
#endif
    
    var body: some View {
#if DEV
        WithViewStore(self.store) { viewStore in
            ZStack{
                VStack {
                    Button {
                        viewStore.send(.addItemButtonTapped)
                    } label: {
                        Text("asdfasdfa")
                    }
                    .bottomSheet(isPresented: viewStore.binding(
                        get: \.isItemAddSheetPresented,
                        send: .addItemButtonTapped
                    )) {
                        VStack {
                            Text("text")
                            Text("text")
                            Text("text")
                            Text("text")
                            Text("text")
                            Text("text")
                        }
                    }
                    
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
                        MediaPicker(image: $image)
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
                MediaPicker(image: $image)
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
