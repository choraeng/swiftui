//
//  GridCell.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/10.
//

import SwiftUI

struct GridCell: View {
    let uiimage: UIImage
    let width: CGFloat
    
    var id: UUID
    var ns: Namespace.ID
    
    private var image: Image {
        let image = uiimage
                    .resize(width: width)
        return Image(uiImage: image)
    }
    
    var body: some View {
//        Color.clear
//            .aspectRatio(1, contentMode: .fit)
//            .overlay(
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//            )
//            .matchedGeometryEffect(id: id, in: ns)
//            .clipped()
        Color.clear.overlay(
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width)
        )
            .clipShape(Rectangle())
            .contentShape(Rectangle())
            .matchedGeometryEffect(id: id, in: ns)
            .frame(height: width)
        
        
        
//        Color.clear
//            .aspectRatio(1, contentMode: .fit)
//            .background(
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//            )
//            .clipped()
    }
}
