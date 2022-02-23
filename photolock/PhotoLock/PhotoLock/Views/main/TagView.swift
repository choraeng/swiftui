//
//  TagView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/23.
//

import SwiftUI

struct SeperatorBar: View {
    var body: some View {
        Color(red: 0.769, green: 0.769, blue: 0.769)
            .frame(maxWidth: .infinity, maxHeight: 0.5)
            .padding(0)
    }
}

struct TagView: View {
    @State var tagName: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .center) {
                Button {
                } label: {
                    CustomText(text: "완료", size: 16, color: Color.textNormal ,weight: .bold)
                }
                .opacity(0)
                
                Spacer()
                
                CustomText(text: "태그", size: 18, color: Color.textNormal ,weight: .bold)
                
                Spacer()
                
                
                Button {
                    
                } label: {
                    CustomText(text: "완료", size: 16, color: Color.textNormal ,weight: .bold)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(Color.background)
            
//            SeperatorBar()
            Divider()
                .padding(0)
            
            Color.white
                .frame(maxWidth: .infinity, maxHeight: 48)
                .overlay(
                    TextField("태그 이름을 입력하세요.", text: $tagName)
                        .frame(maxWidth: .infinity)//, maxHeight: memoHeight)
                        .padding(.horizontal, 16)
                )
            
//            SeperatorBar()
            Divider()
                .padding(0)
            
            CustomText(text: "옵션 선택 또는 생성", size: 13, color: Color.textNormal, weight: .semibold)
                .padding(.top, 30)
                .padding(.leading, 16)
                .padding(.bottom, 10)
            
            ScrollView{
                LazyVStack(spacing:0){
                    ForEach(0...5, id: \.self){ _ in
                        TagRow()
//                        Text("Asdf")
//                            .frame(width: 100, height: 100)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .background(Color(red: 0.958, green: 0.958, blue: 0.958))
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct TagRow: View {
    var body: some View {
        GeometryReader { geo in
//            Text("Asdfasdf")
            VStack(spacing:0){
                Color.background
                    .frame(width: geo.size.width, height: 48)
                    .overlay(
                        HStack(alignment: .center){
                            TagCell(tagName: "tag")
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
