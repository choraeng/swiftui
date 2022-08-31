//
//  ContentView.swift
//  cameraXPN
//
//  Created by 조영훈 on 2022/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CameraXPN(action: { url, data in
            print(url)
            print(data.count)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
