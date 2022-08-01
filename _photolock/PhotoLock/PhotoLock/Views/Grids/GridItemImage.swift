//
//  GridItemImage.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/13.
//

import SwiftUI

struct GridItemImage: View {
    var item: ItemEntity
    
    private var image: Image {
        Image(uiImage: UIImage(data: item.image?.data ?? Data()) ?? UIImage())
    }
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
