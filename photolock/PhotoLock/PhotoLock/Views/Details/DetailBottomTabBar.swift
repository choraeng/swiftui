//
//  DetailBottomTabBar.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/09.
//

import SwiftUI

struct DetailBottomTabBar: View {
    static let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일 "
        return formatter
    }()
    
    @Binding var infoSheet: Bool
    // 삭제 공유 이거 다 바인딩해서 하자 위에 시트처럼
    
//    var isFavorite: Bool
    var index: Int?
//    var currentItem: ItemEntity?
    @EnvironmentObject var CoredataModel: CoreDataViewModel
    
    var currentItem: ItemEntity? {
        if let index = index {
            return CoredataModel.currentItems[index]
        } else {
            return nil
        }
    }
    
    var body: some View {
        //        if let idx = index! {
        HStack(spacing: 0) {
            bottomTabBarCell(img_name: currentItem?.isFavorite ?? false ? "favorite" : "favorite_icon", text: "즐겨찾기"){
                CoredataModel.updateFavorite(item: currentItem!, newValue: !(currentItem!.isFavorite))
//                self.ItemStorage.items[idx].image?.isFavorite.toggle()
//                self.ItemStorage.save()
            }
            
            bottomTabBarCell(img_name: "share_icon", text: "공유하기"){
                
            }
            bottomTabBarCell(img_name: "info_icon", text: "파일정보"){
                infoSheet.toggle()
            }
            
            bottomTabBarCell(img_name: "delete_icon", text: "휴지통"){
                
            }
        } // hstack
        
        //            .frame(width: geometry.size.width, height: 48, alignment: .bottom)
        .background(Color.background)
        //        }
    }
}


struct bottomTabBarCell: View {
    var img_name: String
    var text: String
    
    var completion: () -> Void
    
    
    var body: some View {
        Button {
            completion()
        } label: {
            VStack(spacing: 6) {
                Spacer()
                Image(img_name)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                //                .accentColor((viewtype == contentViewType.grid) ? .primary : .gray)
                    .frame(width: 24.0, height: 24.0)
                //                    .foregroundColor(.black)
                
                CustomText(text: text, size: 12, weight: .regular)
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
    }
}
