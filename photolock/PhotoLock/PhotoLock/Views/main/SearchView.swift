//
//  SearchView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/28.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State var isCommit: Bool = false
    
    @Binding var isSearchMode: Bool
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 27) {
                Button {
                } label: {
                    Image("close_icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .opacity(0)
                
                Button {
                } label: {
                    Text("선택")
                }
                .opacity(0)
                
                Spacer()
                
                CustomText(text: "검색", size: 18, weight: .bold)
                
                Spacer()
                
                
                Button {
                    
                } label: {
                    CustomText(text: "선택", size: 16)
                }
                .opacity(isCommit ? 1 : 0)
                .disabled(!isCommit)
                
                Button {
                    withAnimation {
                        isSearchMode.toggle()
                    }
                } label: {
                    Image("close_icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
            } // hstack
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: 36)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red: 0.946, green: 0.946, blue: 0.946))
                HStack(spacing: 7) {
                    Image("search_icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                        .opacity(0.4)
                    
                    TextField("키워드, 태그로 검색해보세요", text: $searchText, onCommit: {
                        isCommit.toggle()
                    })
                }
            } // zstack
            .frame(maxWidth: .infinity, maxHeight: 44)
            .padding(.horizontal, 16)
            .padding(.vertical, 30)
            
            
            Spacer()
        } // vstack
    } // body
}
