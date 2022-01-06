//
//  ImageDetailView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/28.
//

import SwiftUI

struct ImageDetailView: View {
    var img: Image
    
    var body: some View {
        VStack(spacing: 0) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
//                .navigationTitle(" ")
//                .navigationBarHidden(true)
        }
    } // body
} // View


/// 상단바는 네비게이션바 만들어서 적용하고
/// 가운데는 당연히 이미지 가로 세로 infinity로 적용
/// vstack안에
/// 태그뷰
///     가로 스크롤뷰 적용
/// 메모칸
///     스와이프 제스쳐 정굑
/// 탭바
