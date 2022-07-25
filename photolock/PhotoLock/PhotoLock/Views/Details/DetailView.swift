//
//  ImageFSV.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/21.
//

import SwiftUI

struct ImageFSV: View {
    @GestureState var selectedImageOffset: CGSize
    @Binding var didFinishClosingImage: Bool
    @Binding var showFSV: Bool
    @Binding var selectedImageIndex: Int?
    @Binding var selectedImageScale: CGFloat
    @Binding var isSwiping: Bool //.
    @Binding var isSelecting: Bool // 현재 디테일상태인지
    
    //    public var eventImages: [ImageItem]
    public let geoWidth: CGFloat
    public let geoHeight: CGFloat
    public let namespace: Namespace.ID
    
    @State private var backgroundOpacity: CGFloat = 1
    
    //-----------------------------------
    var statusBarHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
    }
    @State private var keyboardHeight = 0.0
    @State var infoSheet = false
    @State var memoHeight: CGFloat = 44
    @State var isOnlyView: Bool = false
    @State var imageY: CGFloat = 0.0
    
    // 22.02.08 ->
    //        @ObservedObject var ImageStorage: ImageItemStorage
    //    @State var index: Int
    @State var inputMemo: String = ""
    // 22.02.08 <-
    
    @State var isInputMemo: Bool = false
    @State var beforeMemoLen: Int = 0
    @State var isSubView: Bool = true
    @State var isTagView: Bool = false
    
    @EnvironmentObject var CoredataModel: CoreDataViewModel
    
    var currentItem: ItemEntity? {
        if let index = selectedImageIndex {
            return CoredataModel.currentItems[index]
        } else {
            return nil
        }
    }
    
    var title: String {
        var ret = ""
        if selectedImageIndex != nil {
            switch (currentItem!.type) {
            case 0:
                ret = ""
                break
            case 1:
                ret = currentItem!.title ?? " "
                break
            case 2:
                ret = ""
                break
            default:
                break
            }
        }
        return ret
    }
    
    @State var beforeIdx: Int = -1
    
    var body: some View {
        if self.showFSV, let index = self.selectedImageIndex {
            //            ZStack {
            ImageHStack(
                selectedImageOffset: selectedImageOffset,
                didFinishClosingImage: $didFinishClosingImage,
                showFSV: $showFSV,
                selectedImageIndex: $selectedImageIndex,
                selectedImageScale: $selectedImageScale,
                isSwiping: $isSwiping,
                isSelecting: $isSelecting,
                //                eventImages: ImageStorage.imageItems,
                geoWidth: geoWidth,
                geoHeight: geoHeight,
                namespace: namespace,
                images: CoredataModel.currentItems.filter { $0.type == 1 }.map { i in
                    Image(uiImage: UIImage(data: i.image!.data!)!)
                },
                ids: CoredataModel.currentItems.filter { $0.type == 1 }.map { i in
                    i.id!
                }
            )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        isSubView.toggle()
                    }
                }
            
            if isSubView{
                Group{
                    // navibar
                    VStack(spacing: 0) {
                        Color.background // status bar
                            .frame(maxWidth: .infinity, maxHeight: statusBarHeight)
                        //                            .foregroundColor(.background)
                        DetatilNavigation(title: title, didFinishClosingImage: $didFinishClosingImage, showFSV: $showFSV, selectedImageIndex: $selectedImageIndex, isSelecting: $isSelecting) // navigation bar
                        
                        Spacer()
                    } // vstck
                    
                    //bottom bar
                    VStack(spacing: 0){
                        Spacer()
                        VStack(spacing: 0){
                            Spacer()
                            DetailTagView(index: $selectedImageIndex, isTagView: $isTagView) // tag view
                                .fullScreenCover(isPresented:$isTagView, onDismiss: {
                                    
                                }, content: {
                                    TagView(index: $selectedImageIndex)
                                })
                            
                                .background(Color.background)
                            
                            
                            Color(red: 0.958, green: 0.958, blue: 0.958)
                                .frame(maxWidth: .infinity, maxHeight: memoHeight)
                                .overlay(
                                    TextField("메모를 입력하세요", text: $inputMemo)
                                        .frame(maxWidth: .infinity)//, maxHeight: memoHeight)
                                        .padding(.horizontal, 16)
                                        .onChange(of: inputMemo.count, perform: { newValue in
                                            //                                            if beforeMemoLen != newValue {
                                            if beforeIdx == index {
                                                if currentItem != nil {
                                                    CoredataModel.updateNote(item: currentItem!, newNote: inputMemo)
                                                }
                                            }else {
                                                beforeIdx = index
                                            }
                                        })
                                )
                        } // vstack 1
                        .keyboardAdaptive(bottomInset: UIApplication.shared.windows[0].safeAreaInsets.bottom)
                        
                        // bottom tab bar
                        DetailBottomTabBar(infoSheet: $infoSheet,
                                           //                                           isFavorite: $(currentItem!.isFavorite)
                                           //                                           currentItem: currentItem
                                           index: selectedImageIndex,
                                           didFinishClosingImage: $didFinishClosingImage, showFSV: $showFSV, selectedImageIndex: $selectedImageIndex, isSelecting: $isSelecting
                        )
                        
                        Color.white
                            .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: UIApplication.shared.windows[0].safeAreaInsets.bottom)
                    } // vstack2
                    .edgesIgnoringSafeArea(.bottom)
                } // isonlyview
                .onAppear(perform: {
                    if selectedImageIndex != nil {
                        inputMemo = currentItem!.note ?? ""
                    }
                })
                .onChange(of: index, perform: { newValue in
                    //                isInputMemo = false
                    //                    beforeMemoLen = (ImageStorage.imageItems[newValue].image.memo ?? "").count
                    //                    inputMemo = ImageStorage.imageItems[newValue].image.memo ?? ""
                    //                    if selectedImageIndex != nil {
                    inputMemo = currentItem!.note ?? ""
                })
                //                .customBottomSheet(isPresented: $infoSheet, title: "파일정보") {
                //                    bottomSheet
                //                }
                .zIndex(3)
                .ignoresSafeArea(.all)
            }
        }
    } // body
}

extension ImageFSV {
    //    private var bottomSheet: AnyView {
    //        AnyView(
    //            VStack(spacing: 10){
    //                HStack(spacing: 0){
    //                    CustomText(text: "파일명", size: 16, color: .black, weight: .semibold)
    //                        .opacity(0.6)
    //                        .frame(maxWidth: 80, maxHeight: 44)
    //                    if let index = selectedImageIndex {
    //                        switch (ItemStorage.items[index].type) {
    //                        case 0:
    //                            Text("asdf")
    //                        case 1:
    //                            CustomText(text: ItemStorage.items[index].image?.name ?? "", size: 16, color: .black)
    //                        case 2:
    //                            Text("asdf")
    //                        default:
    //                            Text("")
    //                        }
    //                    }
    //
    //                    Spacer()
    //
    //                }
    //                HStack(spacing: 0){
    //                    CustomText(text: "해상도", size: 16, color: .black, weight: .semibold)
    //                        .opacity(0.6)
    //                        .frame(maxWidth: 80, maxHeight: 44)
    //
    //                    if let index = selectedImageIndex {
    //                        switch (ItemStorage.items[index].type) {
    //                        case 0:
    //                            Text("asdf")
    //                        case 1:
    //                            CustomText(text: "\(String(describing: ItemStorage.items[index].image?.width ?? 0))x\(String(describing: ItemStorage.items[index].image?.height ?? 0))", size: 16, color: .black)
    //                        case 2:
    //                            Text("asdf")
    //                        default:
    //                            Text("")
    //                        }
    //                    }
    //
    //                    Spacer()
    //
    //                }
    //                HStack(spacing: 0){
    //                    CustomText(text: "파일크기", size: 16, color: .black, weight: .semibold)
    //                        .opacity(0.6)
    //                        .frame(maxWidth: 80, maxHeight: 44)
    //
    //                    if let index = selectedImageIndex {
    //                        switch (ItemStorage.items[index].type) {
    //                        case 0:
    //                            Text("asdf")
    //                        case 1:
    //                            CustomText(text: String(fileSizeToStr(bytes: ItemStorage.items[index].image?.size ?? 0)), size: 16, color: .black)
    //                        case 2:
    //                            Text("asdf")
    //                        default:
    //                            Text("")
    //                        }
    //                    }
    //                    Spacer()
    //
    //                }
    //                HStack(spacing: 0){
    //                    CustomText(text: "날짜", size: 16, color: .black, weight: .semibold)
    //                        .opacity(0.6)
    //                        .frame(maxWidth: 80, maxHeight: 44)
    //
    //                    if let index = selectedImageIndex {
    //                        switch (ItemStorage.items[index].type) {
    //                        case 0:
    //                            Text("asdf")
    //                        case 1:
    //                            CustomText(text: "\(dateToStr(inputDate:  ItemStorage.items[index].image?.createdAt))", size: 16, color: .black)
    //                        case 2:
    //                            Text("asdf")
    //                        default:
    //                            Text("")
    //                        }
    //                    }
    //                    Spacer()
    //
    //                }
    //
    //            }
    //        )
    //    }
}

