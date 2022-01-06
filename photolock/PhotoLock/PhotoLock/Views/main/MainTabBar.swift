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
            Button {
                viewtype = .grid
                print(viewtype)
            } label: {
                Image("grid_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor((viewtype == contentViewType.grid) ? .primary : .gray)
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
                    .accentColor((viewtype == contentViewType.list) ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            
            Button {
                isFilter.toggle()
                isFilterSheet = true
            } label: {
                Image("funnel_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isFilter ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            
        } // hstack
//        .customBottomSheet(isPresented: $isFilterSheet, title: "정렬") {
//            VStack(spacing: 0) {
//                Text("날짜 오름차순")
//                    .font(.system(size: 16))
//                    .bold()
//            }
//        }
    } //body
} // MainTapBar
//
//struct MainTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBar()
//    }
//}
