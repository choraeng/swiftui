//
//  MainGridView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/08.
//

import SwiftUI

struct MainGridView: View {
    //    @FetchRequest(entity: ImageEntity.entity(), sortDescriptors: []) var newImageItems: FetchedResults<ImageEntity>
    
    
    var gridItemAlbumLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
    
    @Binding var isSelectMode: Bool
    
    // 22.02.05 ->
    @Binding var currentIndex: Int?
    @State var isViewDetail: Bool = false
    @State var clikedImage: ContentImage = ContentImage()
    // 22.02.05 <-
    
    // 22.02.08 ->
    @ObservedObject var ImageStorage: ImageItemStorage
    // 22.02.08 <-
    
    // 22.02.16 ->
    @Binding var isView: Bool
    let ns: Namespace.ID
    @Binding var pickId: UUID
    // 22.02.16 <-
    
    var body: some View {
        //        if !isViewDetail {
        VStack{
            if ImageStorage.imageItems.count == 0 {
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
                        ForEach(0..<ImageStorage.imageItems.count, id: \.self) { i in
//                            NavigationLink{
//                                ImageDetailView(ImageStorage: ImageStorage, index: i)
//                            } label: {
//                            contentCell(isSelectMode: isSelectMode, ns: ns, isView: $isView).environmentObject( ImageStorage.imageItems[i].image)
                            contentCell(imageItem:ImageStorage.imageItems[i], isSelectMode: isSelectMode, ns: ns, isView: $isView, pickId: $pickId, idx: i, currentIndex: $currentIndex)
//                            } // navigation
                        }
                    }
                } // scrollview
            } // else
        } // vstack
    } // body
}



