//
//  DetailTagItem.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct TagItem: View {
//    var tagName: String
//    var r: Double
//    var g: Double
//    var b: Double
//    var a: Double
    var tag: TagEntity
    
    var body: some View {
        Button{
            
        } label: {
            HStack(spacing: 0) {
                CustomText(text: tag.name!, size: 13, color: Color.white, weight: .semibold)
                
                
                Image("close_icon_sm")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(Color.white)
                    .frame(width: 24, height: 24)
            }
        }
        .frame(height: 24)
        .padding(.leading, 8)
        //        .frame(maxWidth: 77, maxHeight: 24)
//        .background(Color(red: 0.384, green: 0.38, blue: 0.4))
        .background(Color(red: tag.r, green: tag.g, blue: tag.b, opacity: tag.a))
        .cornerRadius(4)
    } // body
}
