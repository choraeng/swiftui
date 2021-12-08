//
//  MainListView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/08.
//

import SwiftUI

struct MainListView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]

    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
    
    var body: some View {
        VStack{
        ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 3) {
                    ForEach((0...3), id: \.self) {
                        Image(systemName: symbols[$0 % symbols.count])
                            .font(.system(size: 30))
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fill)
                            .background(Color.blue)
                    }
                }
//            }
//        ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 3) {
                    ForEach((0...9999), id: \.self) {
                        Image(systemName: symbols[$0 % symbols.count])
                            .font(.system(size: 30))
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fill)
                            .background(Color.gray)
                    }
                }
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
