//
//  MainView.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

enum contentViewType: Int {
    case grid
    case list
}

enum mainViewMode: Int {
    case search
    case select
    case setting
    case addAlbum
}

struct MainView: View {
//    @State var contents: [MainContent] = [] // selectedImg: [Image] = []
    @State var viewType: contentViewType = .grid
    
    @State var isFilterSheet = false // 필터 시트를 위한
    @State var isSelectMode = false // 사진 및 앨범 선택을 위해
    @State var isSearchMode = false // 검색 모드
    
    @ObservedObject var sheetStates = ViewStateModel()
    
    // 22.02.16 ->
    @State var isView = false
    @Namespace var isviewnamespace
    @State var pickId: UUID = UUID()
    @State var currentIndex: Int? = 0
    // 22.02.16 <-
    
    @State var zoom: CGFloat = 1
    @State var done: Bool = false
    
    @GestureState private var selectedImageOffset: CGSize = .zero //
    @State private var isSwiping: Bool = false //.
    @State private var isSelecting: Bool = false // 현재 디테일상태인지
    @State var didFinishClosingImage: Bool = true // 사진 디테일 뷰 끝났는지
    @State private var showFSV: Bool = false // 사진 디테일 뷰 시작
    @State private var selectedImageScale: CGFloat = 1 // 선택한 이미지 크기
    
    var body: some View {
        GeometryReader { geo in
            let geoWidth = geo.size.width + geo.safeAreaInsets.leading + geo.safeAreaInsets.trailing
            let geoHeight = geo.size.height + geo.safeAreaInsets.top + geo.safeAreaInsets.bottom
            NavigationView {
                ZStack{
                    //                if !isView {
                    VStack(spacing: 0) {
                        if isSearchMode {
                            SearchView(isSearchMode: $isSearchMode)
                        } else {
                            MainNavigationView(isSelectMode: $isSelectMode, isSearchMode: $isSearchMode)
                                .environmentObject(sheetStates)
                            
                            MainTabBar(viewtype: $viewType, isFilterSheet: $isFilterSheet)
                                .padding(.vertical, 6)
                            
                            if viewType == .grid {
                                MainGridView(isSelectMode: $isSelectMode, currentIndex: $currentIndex, isView: $isView, ns: isviewnamespace, pickId: $pickId)
                            }else {
//                                MainListView(contents: $contents)
                            }
                            //                        }
                        }
                    } // vstack
                    
                    if !isSearchMode{
                        floatingButton()
                            .environmentObject(sheetStates)
                    }
                } // zstack
                .navigationBarHidden(true)
                .customBottomSheet(isPresented: $isFilterSheet, title: "정렬") {
                    AnyView(filterSheetView())
                } // filter sheet
                .customBottomSheet(isPresented: $sheetStates.albumAddSheetShowing, title: "앨범 추가") {
                    AnyView(addViewOnBottomSheet(addType: "앨범"))
                } // album add
                .customBottomSheet(isPresented: $sheetStates.memoAddSheetShowing, title: "메모 추가") {
                    AnyView(addViewOnBottomSheet(addType: "메모"))
                } // album add
            } // naviagation
            
            ImageFSV(
                selectedImageOffset: selectedImageOffset,
                didFinishClosingImage: $didFinishClosingImage,
                showFSV: $isView,
                selectedImageIndex: $currentIndex,
                selectedImageScale: $selectedImageScale,
                isSwiping: $isSwiping,
                isSelecting: $isSelecting,
                geoWidth: geoWidth,
                geoHeight: geoHeight,
                namespace: isviewnamespace
            )
        }
    } // body
} // mainview



extension MainView {
    
} // mainView
