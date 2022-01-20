//
//  ImageDetailView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/28.
//

import SwiftUI

struct ImageDetailView: View {
    @ObservedObject var keyboardResponder = KeyboardResponder()
    var img: Image
    var statusBarHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
    }
    
    @State var memo: String = ""
    
    var body: some View {
        ZStack {
            img
            //            Image("App")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .offset(y: -keyboardResponder.currentHeight*0.3)
//                .ignoresSafeArea(.keyboard)
            
            VStack(spacing: 0) {
                Rectangle() // status bar
                    .frame(maxWidth: .infinity, maxHeight: statusBarHeight)
                    .foregroundColor(.background)
                
                DetatilNavigation(title: "IMG_123") // navigation bar
                    .background(Color.background)
                
                Spacer()
                
                DetailTagView() // tag view
                    .background(Color.background)
                
                Color(red: 0.958, green: 0.958, blue: 0.958)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .overlay(
                        TextField("메모를 입력하세요", text: $memo)
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .padding(.horizontal, 16)
//                            .edgesIgnoringSafeArea(.horizontal)
                    )
                
                DetailBottomTabBar() // bottom tab bar
                
//                Color.white
                Color.background
                    .frame(maxWidth: .infinity, maxHeight: 40)
            } // vstack
            .padding(.bottom, -40)
            .offset(y: -keyboardResponder.currentHeight*0.9)
        } // zstack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .ignoresSafeArea(.keyboard)
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
struct DetatilNavigation: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var title: String = ""
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("back_arrow_icon")
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size:16))
            
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

struct DetailTagView: View {
    var body: some View {
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
                    TagCell(tagName: "1234")
                    TagCell(tagName: "2345")
                    TagCell(tagName: "3456")
                    TagCell(tagName: "4567")
                    TagCell(tagName: "4567")
                    TagCell(tagName: "4567")
                    TagCell(tagName: "4567")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .padding(.horizontal, 16)
        } // vstack
    } // body
}

struct TagCell: View {
    var tagName: String
    
    var body: some View {
        HStack(spacing: 0) {
            CustomText(text: tagName, size: 13, color: Color.white, weight: .semibold)
                .padding(.leading, 8)

            Image("close_icon_sm")
            //                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.white)
            //                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: 77, maxHeight: 24)
        .background(Color(red: 0.384, green: 0.38, blue: 0.4))
        .cornerRadius(4)
    } // body
} // tagcell




///////////////////////////////////
