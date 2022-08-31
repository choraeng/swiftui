//
//  ContentView.swift
//  modules_test
//
//  Created by 조영훈 on 2022/08/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        imageVstack().environmentObject(ImageData())
        swiftuicam()
//        GeometryReader{ reader in
//            cameraxpn()
//                .onAppear {
//                    print(reader.size)
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
