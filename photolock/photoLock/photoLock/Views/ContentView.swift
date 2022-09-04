//
//  ContentView.swift
//  photoLock
//
//  Created by user on 2022/08/08.
//

import SwiftUI

#if DEV
import test
#endif

struct ContentView: View {
    @State var camera: Bool = false
    @State private var image: UIImage?
    var body: some View {
        #if DEV
        VStack {
            test()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
