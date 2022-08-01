//
//  MainTabBarItem.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct MainTabBarItem: View {
    var img_name: String
    var content: () -> Void
    
    var body: some View {
        Button {
            content()
        } label: {
            Image(img_name)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
            //                .accentColor((viewtype == contentViewType.grid) ? .primary : .gray)
                .frame(width: 24.0, height: 24.0)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
    }
}
