//
//  ContentView.swift
//  photoLock
//
//  Created by user on 2022/08/08.
//

import SwiftUI

struct ContentView: View {
    @State var camera: Bool = false
    var body: some View {
        VStack {
            Button {
                camera.toggle()
            } label: {
                Text("카메라")
            }
            .fullScreenCover(isPresented: $camera) {
                
            } content: {
                CameraXPN(action: { url, data in
                    print(url)
                    print(data.count)
                })
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
