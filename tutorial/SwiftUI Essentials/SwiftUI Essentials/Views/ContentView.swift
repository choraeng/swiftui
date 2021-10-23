//
//  ContentView.swift
//  SwiftUI Essentials
//
//  Created by 조영훈 on 2021/07/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
