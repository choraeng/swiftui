//
//  ContentView.swift
//  photoLock
//
//  Created by user on 2022/08/08.
//

import SwiftUI

#if DEV
//import test
import SwiftUIBottomSheet
import FloatingButton
#endif

struct ContentView: View {
    @State var camera: Bool = false
    @State private var image: UIImage?
    
#if DEV
    @State var modal = false
    @State var isclick = false
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
#endif
    
    var body: some View {
#if DEV
        ZStack{
            VStack {
                Button {
                    modal.toggle()
                } label: {
                    Text("asdfasdfa")
                }
                .bottomSheet(isPresented: $modal) {
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
            
            
            FloatingButton($isclick)
                .bottomSheet(isPresented: $isclick) {
                    VStack {
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                        Text("text")
                    }
                }
                .onChange(of: modal) { newValue in
                    print(newValue)
                }
            
            subView(vm: CoreDataViewModel(_managedObjectContext: managedObjectContext))
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

struct subView: View {
    @StateObject var vm: CoreDataViewModel
    
    var body: some View {
        Text("Asdf")
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
