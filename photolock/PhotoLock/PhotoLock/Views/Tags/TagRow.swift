//
//  TagRow.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct TagRow: View {
    var tagName: String
    var body: some View {
        GeometryReader { geo in
//            Text("Asdfasdf")
            VStack(spacing:0){
                Color.background
                    .frame(width: geo.size.width, height: 48)
                    .overlay(
                        HStack(alignment: .center){
                            TagItem(tagName: tagName)
                            Spacer()
                            Button{

                            } label: {
                                Image("more_icon")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color.black)
                                    .frame(width: 24, height: 24)
                                    .opacity(0.4)
                            }
                        }
                            .padding(.horizontal, 16)
                    )
//                SeperatorBar()
                Divider()
                    .padding(0)
            }
        }
        .frame(height: 48.5)
        .padding(0)
    }
}

