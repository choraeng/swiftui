//
//  MainGridView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/08.
//

import SwiftUI

struct MainGridView: View {
    var gridItemAlbumLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
    
    @Binding var contents: [MainContent]
    @Binding var isSelectMode: Bool
    
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
                    ForEach((0..<contents.count), id: \.self) { idx in
                        ZStack(alignment: .topLeading) {
                            contentCell(img: contents[idx].img)
                            
                            Rectangle()
                                .fill(Color.black)
                                .aspectRatio(1, contentMode: .fit)
                                .opacity(0.2)
                            
                            checkCircle()
                        }
                    }
                }
            }
        }
    }
}

struct checkCircle: View {
    
    var body: some View {
        ZStack() {
            
//            Circle()
//                .strokeBorder(Color.white, lineWidth: 1.5)
//                .background(Circle().foregroundColor(Color.clear))
//                  .frame(width: 22.5, height: 22.5)
            
            Circle()
                .strokeBorder(Color.white, lineWidth: 1.5)
                .background(Circle().foregroundColor(ColorPalette.primary.color))
                .frame(width: 22.5, height: 22.5)
            
            
            Image("check_icon_rounded")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.white)
                .background(Color.clear)
                .frame(width: 10, height: 8)
                
            
        }
        .padding(8)
    }
}
//
//struct MainGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainGridView()
//    }
//}
