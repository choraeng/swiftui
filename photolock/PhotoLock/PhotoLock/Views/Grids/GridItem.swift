//
//  contentCell.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/17.
//

import SwiftUI

struct contentCell: View {
    var item: ItemEntity
    var isSelectMode: Bool
    
    let ns: Namespace.ID
    @Binding var isView: Bool
    @Binding var pickId: UUID
    
    let idx: Int
    @Binding var currentIndex: Int?
    
    private var image: Image {
        Image(uiImage: UIImage(data: item.image?.data ?? Data()) ?? UIImage())
    }
    
    var body: some View {
        if !(isView && currentIndex! == idx) {
            Button {
                DispatchQueue.main.async {
                    withAnimation(.easeIn(duration: 0.2)) {
                        currentIndex = idx
                        isView.toggle()
                    }
                }
            } label: {
                ZStack {
                    Color.clear
                        .aspectRatio(1, contentMode: .fit)
                        .background(
                            GridItemImage(item: item)
                                
                        )
                        .matchedGeometryEffect(id: item.id!, in: ns, isSource: isView ? false : true)
                        .clipped()
                        
                    // favorite
//                    if let favor = item.image?.isFavorite{
//                        if favor{
//                            GridItemFavorite()
//                        }
//                    }
//
//                    // check
//                    if isSelectMode {
//                        Rectangle()
//                            .fill(Color.black)
//                            .aspectRatio(1, contentMode: .fit)
//                            .opacity(0.2)
//                        GridItemCheck()
//                    }
                } // zstack
                
            } // button
            .zIndex(0)
        } else {
            Color.clear
        }
    } // body
}
