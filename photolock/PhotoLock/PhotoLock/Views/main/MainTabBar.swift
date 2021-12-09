//
//  MainTabBar.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

struct MainTabBar: View {
    enum ViewType {
        case grid
        case list
    }
    
    @State var viewtype: ViewType = .grid
    @State var isFilter: Bool = false
    
    var body: some View {
        HStack (alignment: .center, spacing: 0) {
            Button {
                viewtype = .grid
                print(viewtype)
            } label: {
                Image("grid_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor((viewtype == ViewType.grid) ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            
            Button {
                viewtype = .list
                print(viewtype)
            } label: {
                Image("list_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor((viewtype == ViewType.list) ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            
            Button {
                isFilter.toggle()
            } label: {
                Image("funnel_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isFilter ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }.frame(maxWidth: .infinity, maxHeight: 40)
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
    }
}
