//
//  MainGridView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/08.
//

import SwiftUI

struct MainGridView: View {
    var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    var gridItemAlbumLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
    
    @Binding var selectedImage: [Image]
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: gridItemAlbumLayout, spacing: 3) {
                    ForEach((0...3), id: \.self) {_ in
                        albumCell()
                    }
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 10)
                //            }
                //        ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 3) {
                    ForEach((0..<selectedImage.count), id: \.self) { idx in
                        contentCell(img: selectedImage[idx])
//                        Image(systemName: symbols[$0 % symbols.count])
//                            .font(.system(size: 30))
//                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
//                            .aspectRatio(1, contentMode: .fill)
//                            .background(Color.gray)
                    }
                }
            }
        }
    }
}
//
//struct MainGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainGridView()
//    }
//}
