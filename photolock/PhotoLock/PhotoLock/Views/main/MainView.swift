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
    @State var contents: [MainContent] = [] // selectedImg: [Image] = []
    @State var viewType: contentViewType = .grid
    
    @State var isFilterSheet = false // 필터 시트를 위한
    @State var isSelectMode = false // 사진 및 앨범 선택을 위해
    @State var isSearchMode = false // 검색 모드
    
    @ObservedObject var sheetStates = ViewStateModel()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    if isSearchMode {
                        SearchView(isSearchMode: $isSearchMode)
                    } else {
                        MainNavigationView(isSelectMode: $isSelectMode, isSearchMode: $isSearchMode)
                            .environmentObject(sheetStates)
                        
                        MainTabBar(viewtype: $viewType, isFilterSheet: $isFilterSheet)
                            .padding(.vertical, 6)
                        
                        
//                        if newImageItems.isEmpty {//contents.isEmpty {
//                            ZStack {
//                                VStack (spacing: 21) {
//                                    Image("add_arrow")
//                                        .opacity(0)
//
//                                    CustomText(text: "비어있음", size: 24, weight: .bold)
//
//                                    CustomText(text: "업로드를 위해 하단의 업로드 버튼을\n눌러주세요", size: 16)
//                                        .multilineTextAlignment(.center)
//
//                                    HStack {
//                                        Spacer()
//
//                                        Image("add_arrow")
//                                            .padding(.horizontal, 45)
//                                    }
//                                }
//                            }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        } else{
                            if viewType == .grid {
                                MainGridView(isSelectMode: $isSelectMode)
                            }else {
                                MainListView(contents: $contents)
                            }
//                        }
                    }
                } // vstack
                
                if !isSearchMode{
                    floatingButton()
                        .environmentObject(sheetStates)
//                        .onChange(of: contents.count) { newValue in
//                            for i in contents {
//                                let newImage = ImageEntity(context: viewContext)
//                                newImage.name = i.name
//                                newImage.size = i.size
//                                newImage.height = Int16(i.height)
//                                newImage.width = Int16(i.width)
//                                newImage.isFavorite = false
//                                newImage.data = i.img!//(contents[0].img! as! UIImage).jpegData(compressionQuality: 1.0)
//                                newImage.tags = ""
//                                newImage.memo = ""
//                                saveItem()
//                            }
//                            contents = []
//                        }
                        
                        
                }
            } // zstack
            .customBottomSheet(isPresented: $isFilterSheet, title: "정렬") {
                AnyView(filterSheetView())
            } // filter sheet
            .customBottomSheet(isPresented: $sheetStates.albumAddSheetShowing, title: "앨범 추가") {
                AnyView(addViewOnBottomSheet(addType: "앨범"))
            } // album add
            .customBottomSheet(isPresented: $sheetStates.memoAddSheetShowing, title: "메모 추가") {
                AnyView(addViewOnBottomSheet(addType: "메모"))
            } // album add
            .navigationBarHidden(true)
        }
    } // body
    
//    func saveItem() {
//        DispatchQueue.main.async(){
//            do {
//
//                try viewContext.save()
//
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
} // mainview



extension MainView {
    
} // mainView
