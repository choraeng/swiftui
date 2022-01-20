//
//  DetailBottomTabBar.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/09.
//

import SwiftUI

struct DetailBottomTabBar: View {
    var body: some View {
        
        HStack(spacing: 0) {
            bottomTabBarCell(img_name: "favorite_icon", text: "즐겨찾기")
            bottomTabBarCell(img_name: "share_icon", text: "공유하기")
            bottomTabBarCell(img_name: "info_icon", text: "파일정보")
            bottomTabBarCell(img_name: "delete_icon", text: "휴지통")
        }
        
        //            .frame(width: geometry.size.width, height: 48, alignment: .bottom)
        .background(Color.background)
    }
}


struct bottomTabBarCell: View {
    var img_name: String
    var text: String
    
    
    var body: some View {
        Button {
            
        } label: {
            VStack(spacing: 6) {
                Spacer()
                Image(img_name)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                //                .accentColor((viewtype == contentViewType.grid) ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                    .foregroundColor(.black)
                
                CustomText(text: text, size: 9, weight: .regular)
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
    }
}
