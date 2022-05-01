//
//  ImageDetailView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/28.
//

import SwiftUI
import Combine


/// 상단바는 네비게이션바 만들어서 적용하고
/// 가운데는 당연히 이미지 가로 세로 infinity로 적용
/// vstack안에
/// 태그뷰
///     가로 스크롤뷰 적용
/// 메모칸
///     스와이프 제스쳐 정굑
/// 탭바
struct DetatilNavigation: View {
    //    @Environment(\.presentationMode) var presentationMode // : Binding<PresentationMode>
    //    @Environment(\.dismiss) private var dismiss
    
    
    var title: String = ""
    
    @Binding var didFinishClosingImage: Bool
    @Binding var showFSV: Bool
    @Binding var selectedImageIndex: Int?
    @Binding var isSelecting: Bool // 현재 디테일상태인지
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                isSelecting = true
                withAnimation(.interactiveSpring()) {
                    didFinishClosingImage = false
                    showFSV = false
                    selectedImageIndex = nil
                    isSelecting = false
                }
            } label: {
                Image("back_arrow_icon")
            }
            
            Spacer()
            
            CustomText(text: title, size: 16, color: Color.textNormal ,weight: .semibold)
            
            Spacer()
            
            
            Button {
            } label: {
                Image("back_arrow_icon")
            }
            .opacity(0)
        }
        .padding(.horizontal, 16)
        .frame(height: 40)
        .background(Color.background)
    }
}


