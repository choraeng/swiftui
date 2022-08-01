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
    
    @Binding var isSelectMode: Bool
    
    // 22.02.05 ->
    @Binding var currentIndex: Int?
    @State var isViewDetail: Bool = false
    // 22.02.05 <-
    
    // 22.02.16 ->
    @Binding var isView: Bool
    let ns: Namespace.ID
    @Binding var pickId: UUID
    // 22.02.16 <-
    
    @EnvironmentObject var CoreDataModel: CoreDataViewModel
    
    var body: some View {
        //        if !isViewDetail {
        VStack{
            if CoreDataModel.currentItems.count == 0 {
                emtpyView()
            } else {
                ScrollView {
                    // 앨범 리스트
                    //                LazyVGrid(columns: gridItemAlbumLayout, spacing: 3) {
                    //                    ForEach((0...3), id: \.self) {_ in
                    //                        albumCell()
                    //                    }
                    //                }
                    //                .padding(.horizontal, 9)
                    //                .padding(.vertical, 10)
                    //            }
                    //        ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 3) {
                        //                        ForEach(newImageItems) { item in
                        if let items = CoreDataModel.currentItems {
                            ForEach(0..<items.count, id: \.self) { i in
                                contentCell(item:CoreDataModel.currentItems[i],
                                            isSelectMode: isSelectMode,
                                            ns: ns,
                                            isView: $isView,
                                            pickId: $pickId,
                                            idx: i,
                                            currentIndex: $currentIndex)
                            }
                        }
                    }
                } // scrollview
            } // else
        } // vstack
    } // body
}



