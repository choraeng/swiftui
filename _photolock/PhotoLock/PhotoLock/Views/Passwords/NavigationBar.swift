//
//  NavigationBar.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/29.
//

import SwiftUI

struct NavigationBar<Content: View, Content1: View>: View {
//    @Binding var left_view: AnyView
//    @Binding var right_view: AnyView
    let content1: Content
    let content2: Content1
    
//    init(@ViewBuilder content1: () -> Left, @ViewBuilder content2: () -> Right) {
    init(@ViewBuilder content1: () -> Content, @ViewBuilder content2: () -> Content1) {
        self.content1 = content1()
        self.content2 = content2()
    }
    
    var body: some View {
        HStack {
            content1
                .padding(.leading, 16)
            
            Spacer()
            
            content2
                .padding(.trailing, 16)
        }
        .frame(height: 44)
        .padding(.top, 12)
    }
    
//    var body: some View {
//        HStack {
//            left_view
//                .padding(.leading, 16)
//
//            Spacer()
//
//            right_view
//                .padding(.trailing, 16)
//        }
//        .frame(height: 44)
//        .padding(.top, 12)
////        .background(Color.red)
//    }
}

//struct NavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
////        NavigationBar(left_view: AnyView(Button("취소"){}),
////                      right_view: AnyView(Button("다음"){}))
//        NavigationBar()
//    }
//}
