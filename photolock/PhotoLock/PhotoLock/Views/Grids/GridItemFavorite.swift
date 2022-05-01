//
//  GridItemFavorite.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct GridItemFavorite: View {
    var body: some View {
        //        ZStack(alignment: .bottomLeading) {
        VStack{
            Spacer()
            HStack{
                Image("favorite")
                    .resizable()
                //                .renderingMode(.template)
                //                .foregroundColor(Color.white)
                //                .background(Color.clear)
                    .frame(width: 24, height: 24)
                Spacer()
            }
        }
        .padding(8)
    }
}
