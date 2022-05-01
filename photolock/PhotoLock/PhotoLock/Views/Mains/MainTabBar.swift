//
//  MainTabBar.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

struct MainTabBar: View {
    @Binding var viewtype: contentViewType
    @State var isFilter: Bool = false
    @Binding var isFilterSheet: Bool
    
    var body: some View {
        HStack (alignment: .center, spacing: 0) {
            MainTabBarItem(img_name: "grid_icon") {
                viewtype = .grid
                print(viewtype)
            }
            .accentColor((viewtype == contentViewType.grid) ? .foreground : .gray)
            
            MainTabBarItem(img_name: "list_icon") {
                viewtype = .list
                print(viewtype)
            }
            .accentColor((viewtype == contentViewType.list) ? .foreground : .gray)
            
            MainTabBarItem(img_name: "funnel_icon") {
                isFilter.toggle()
                isFilterSheet = true
            }
            .foregroundColor(isFilter ? .foreground : .gray)
        } // hstack
    } //body
} // MainTapBar
