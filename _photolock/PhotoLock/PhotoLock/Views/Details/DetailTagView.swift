//
//  DetailTagView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct DetailTagView: View {
//    @ObservedObject var ImageStorage: ImageItemStorage
    @Binding var index: Int?
    @Binding var isTagView: Bool
    
    @EnvironmentObject var CoreDataModel: CoreDataViewModel
    
    var body: some View {
        if self.index != nil {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Text("태그")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.horizontal, 19)
                    
                    Spacer()
                } // hstack
                .frame(maxWidth: .infinity, maxHeight: 44)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
//                        if ImageStorage.imageItems[index!].image.tags!.count == 0 {
                        if CoreDataModel.currentItems[index!].tags?.count == 0 {
                            Button {
//                                ImageStorage.imageItems[index!].image.tags!.append("test")
//                                ImageStorage.save()
                                isTagView.toggle()
                            } label: {
                                CustomText(text: "+ 태그추가", size: 13, color: Color.white, weight: .semibold)
                                    .padding(.horizontal, 8)
                            }
                            .frame(height: 24)
                            //                        .frame(maxWidth: 71, maxHeight: 24)
                            .background(Color(red: 0.604, green: 0.604, blue: 0.604))
                            .cornerRadius(4)
                        } else {
//                            ForEach(0..<CoreDataModel.currentItems[index!].tags!.count, id: \.self) { idx in
                            ForEach(CoreDataModel.getTagList(idx: index!), id: \.self) { item in
                                HStack(spacing: 0) {
                                    Button {
                                        isTagView.toggle()
                                    } label: {
                                        CustomText(text: "\(item.name ?? "")", size: 13, color: Color.white, weight: .semibold)
                                    }
                                    .padding(.leading, 8)
                                    Button {
                                        CoreDataModel.deleteTag(tag: item)
                                    } label: {
                                        Image("close_icon_sm")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                    }
                                }
                                .frame(height: 24)
                                //                        .frame(maxWidth: 71, maxHeight: 24)
                                .background(Color(red: item.r, green: item.g, blue: item.b, opacity: item.a))
                                .cornerRadius(4)
                            }
                        }
//                        }else {
//                            ForEach(0..<ImageStorage.imageItems[index!].image.tags!.count) { idx in
////                                TagCell(tagName: ImageStorage.imageItems[index!].image.tags[idx])
////                                    .onTapGesture {
////                                        isTagView.toggle()
////                                    }
//                            }
//                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .padding(.horizontal, 16)
            } // vstack
            .background(Color.background)
        }
    } // body
}
