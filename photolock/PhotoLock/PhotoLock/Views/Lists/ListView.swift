////
////  MainListView.swift
////  PhotoLock
////
////  Created by ์กฐ์ํ on 2021/12/08.
////
//
//import SwiftUI
//
//struct MainListView: View {
//    @Binding var contents: [MainContent]
//
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 0) {
//                ForEach(contents) {content in
//                    cell(content: content)
//                }
//            }
//        }
//    }
//}
//
//
//extension MainListView {
//    struct cell: View {
//        var content: MainContent
//
//        var body: some View {
//            HStack(alignment: .center,  spacing: 16) {
////                contentCell(img: Image(uiImage: UIImage(data: content.img!)!))
//
//                VStack(alignment: .leading, spacing: 4) {
//                    CustomText(text: "title", size: 16)
//                    //                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//                    CustomText(text: "sub", size: 13)
//                        .opacity(0.4)
//                    //                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                }
//                .frame(maxWidth: .infinity, maxHeight: 39, alignment: .leading)
//                //                .padding(.vertical, 20.5)
//            }
//            .frame(maxWidth: .infinity, maxHeight: 80)
//            .padding(.horizontal, 9)
//            .padding(.vertical, 2)
//        }
//
//    }
//}
//
////
////struct MainListView_Previews: PreviewProvider {
////    static var previews: some View {
////        MainListView()
////    }
////}
