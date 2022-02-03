//
//  ImageDetailView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/28.
//

import SwiftUI
import Combine


struct ImageDetailView: View, KeyboardAwareModifier{
    var statusBarHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
    }
    
//    @ObservedObject var keyboardResponder = KeyboardResponder()
    @State private var isKeyboardVisible = false
    @State private var keyboardHeight = 0.0
    @State private var bottomPadding = 0
//    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    @Binding var cImage: ContentImage
    @State var infoSheet = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //            Color.black
            //                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //            Image(uiImage: UIImage(data: cImage.data!)!)
            //            //            Image("App")
            //                .resizable()
            //                .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                .scaledToFit()
            //                .edgesIgnoringSafeArea(.all)
            //                .offset(x: -8)
            MyScrollView(content:
                            Image(uiImage: UIImage(data: cImage.data!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
            )
            //                .offset(y: -keyboardResponder.currentHeight*0.3) // 이거 왜 했지?
            //                .ignoresSafeArea(.keyboard)
            
            //            ScrollViwe
            VStack(spacing: 0) {
                Rectangle() // status bar
                    .frame(maxWidth: .infinity, maxHeight: statusBarHeight)
                    .foregroundColor(.background)
                
                DetatilNavigation(title: cImage.name) // navigation bar
                    .background(Color.background)
                
                Spacer()
            } // vstck
            
            VStack(spacing: 0){
                    Spacer()
                    
                    DetailTagView(cImage: $cImage) // tag view
                        .background(Color.background)
                    
                    
                    Color(red: 0.958, green: 0.958, blue: 0.958)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .overlay(
                            TextField("메모를 입력하세요", text: $cImage.memo)//, onEditingChanged: { if $0 { self.kGuardian.showField = 0 } })
                                .frame(maxWidth: .infinity, maxHeight: 44)
                                .padding(.horizontal, 16)
//                                                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            
                            ///
                            ///
                            ///
                            ///
                            ///
                            ///
                            //                            .edgesIgnoringSafeArea(.horizontal)
                                                        
                        )
//                        .readSize {
//                            print($0)
//                        }
//                        .onChange(of: keyboardResponder.currentHeight, perform: { newValue in
//                            print("height: ", newValue)
//                        })
                        .onReceive(keyboardHeightPublisher) { newValue in
                            withAnimation(.easeOut(duration: 0.3)) {
                                keyboardHeight = newValue
                            }
                        }
                        .padding(.bottom, keyboardHeight>0 ? 0 : 48)
//                        .onReceive(keyboardPublisher) { newValue in
//                            print(newValue)
//
////                            bottomPadding = 100
//                        }
//                }
//                VStack(){
//                    DetailBottomTabBar(infoSheet: $infoSheet, cImage: $cImage) // bottom tab bar
//                }
//                .ignoresSafeArea(.keyboard)
            } // vstack 1
//                        .offset(y: kGuardian.slide)//.animation(.easeInOut(duration: 0.7))
//                        .onChange(of: kGuardian.slide) { newValue in
//                            print(newValue)
//                        }
                        VStack{
                            Spacer()
                            DetailBottomTabBar(infoSheet: $infoSheet, cImage: $cImage) // bottom tab bar
                        } // vstack2
                        .padding(.top, UIApplication.shared.windows[0].safeAreaInsets.top)
                        .ignoresSafeArea(.keyboard)
            
        } // zstack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        //        .ignoresSafeArea(.keyboard)
        .customBottomSheet(isPresented: $infoSheet, title: "파일정보") {
            AnyView(
                VStack(spacing: 10){
                    HStack(spacing: 0){
                        CustomText(text: "파일명", size: 16, color: .black, weight: .semibold)
                            .opacity(0.6)
                            .frame(maxWidth: 80, maxHeight: 44)
                        CustomText(text: cImage.name, size: 16, color: .black)
                        Spacer()
                        
                    }
                    HStack(spacing: 0){
                        CustomText(text: "해상도", size: 16, color: .black, weight: .semibold)
                            .opacity(0.6)
                            .frame(maxWidth: 80, maxHeight: 44)
                        CustomText(text: "\(cImage.width)x\(cImage.height)", size: 16, color: .black)
                        Spacer()
                        
                    }
                    HStack(spacing: 0){
                        CustomText(text: "파일크기", size: 16, color: .black, weight: .semibold)
                            .opacity(0.6)
                            .frame(maxWidth: 80, maxHeight: 44)
                        CustomText(text: String(fileSizeToStr(bytes: cImage.size)), size: 16, color: .black)
                        Spacer()
                        
                    }
                    HStack(spacing: 0){
                        CustomText(text: "날짜", size: 16, color: .black, weight: .semibold)
                            .opacity(0.6)
                            .frame(maxWidth: 80, maxHeight: 44)
                        CustomText(text: "\(dateToStr(inputDate:  cImage.createdAt))", size: 16, color: .black)
                        Spacer()
                        
                    }
                    
                }
            )
        } // zstack custombottom
//        .onAppear { self.kGuardian.addObserver() }
//        .onDisappear { self.kGuardian.removeObserver() }
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
    @Binding var cImage: ContentImage
    
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
                    if cImage.tags.count == 0 {
                        Button {
                            
                        } label: {
                            CustomText(text: "+ 태그추가", size: 13, color: Color.white, weight: .semibold)
                                .padding(.horizontal, 8)
                        }
                        .frame(height: 24)
                        //                        .frame(maxWidth: 71, maxHeight: 24)
                        .background(Color(red: 0.604, green: 0.604, blue: 0.604))
                        .cornerRadius(4)
                    }else {
                        ForEach(0..<cImage.tags.count) { idx in
                            TagCell(tagName: cImage.tags[0])
                        }
                    }
                    //                    TagCell(tagName: "1234")
                    //                    TagCell(tagName: "2345")
                    //                    TagCell(tagName: "3456")
                    //                    TagCell(tagName: "4567")
                    //                    TagCell(tagName: "4567")
                    //                    TagCell(tagName: "4567")
                    //                    TagCell(tagName: "4567")
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
        Button{
            
        } label: {
            HStack(spacing: 0) {
                CustomText(text: tagName, size: 13, color: Color.white, weight: .semibold)
                
                
                Image("close_icon_sm")
                //                .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.white)
                //                .frame(width: 24, height: 24)
            }
        }
        .frame(height: 24)
        .padding(.horizontal, 8)
        //        .frame(maxWidth: 77, maxHeight: 24)
        .background(Color(red: 0.384, green: 0.38, blue: 0.4))
        .cornerRadius(4)
    } // body
} // tagcell




///////////////////////////////////
///
//struct SizePreferenceKey: PreferenceKey {
////  static var defaultValue: CGSize = .zero
//    static var defaultValue: CGFloat = .zero
//  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
//}
//
//extension View {
//  func readSize(onChange: @escaping (CGFloat) -> Void) -> some View {
//    background(
//      GeometryReader { geometryProxy in
//          let frame = geometryProxy.frame(in: CoordinateSpace.local)
////          frame.origin.y
////          return Text("\(frame.origin.x), \(frame.origin.y), \(frame.size.width), \(frame.size.height)")
//        Color.clear
//              .preference(key: SizePreferenceKey.self, value: frame.origin.y)//geometryProxy.size)
//      }
//    )
//    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
//  }
//}
