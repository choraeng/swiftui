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
    @ObservedObject var ImageStorage: ImageItemStorage
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
    //    @ObservedObject var ImageStorage: ImageItemStorage
    //    @State var index: Int
    @State var inputMemo: String = ""
    // 22.02.08 <-
    
    @State var isInputMemo: Bool = false
    @State var beforeMemoLen: Int = 0
    
    @State var isSubView: Bool = true
    
    @State var isTagView: Bool = false
    
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
                eventImages: ImageStorage.imageItems,
                geoWidth: geoWidth,
                geoHeight: geoHeight,
                namespace: namespace
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
                        DetatilNavigation(title: ImageStorage.imageItems[selectedImageIndex!].image.name ?? "", didFinishClosingImage: $didFinishClosingImage, showFSV: $showFSV, selectedImageIndex: $selectedImageIndex, isSelecting: $isSelecting) // navigation bar
                        
                        Spacer()
                    } // vstck
                    
                    //bottom bar
                    VStack(spacing: 0){
                        Spacer()
                        VStack(spacing: 0){
                            Spacer()
                            DetailTagView(ImageStorage: ImageStorage, index: $selectedImageIndex, isTagView: $isTagView) // tag view
                                .fullScreenCover(isPresented:$isTagView, onDismiss: {
                                    
                                }, content: {
                                    TagView()
                                })

                            //                        .background(Color.background)
                            
                            
                            Color(red: 0.958, green: 0.958, blue: 0.958)
                                .frame(maxWidth: .infinity, maxHeight: memoHeight)
                                .overlay(
                                    TextField("메모를 입력하세요", text: $inputMemo)
                                        .frame(maxWidth: .infinity)//, maxHeight: memoHeight)
                                        .padding(.horizontal, 16)
                                        .onChange(of: inputMemo.count, perform: { newValue in
                                            if beforeMemoLen != newValue {
                                                ImageStorage.imageItems[index].image.memo = inputMemo
                                                ImageStorage.save()
                                                beforeMemoLen = newValue
                                            }
                                        })
                                )
                        } // vstack 1
                        
                        //                    .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .local)
                        //                                .onEnded({ value in
                        //                        if value.translation.width < 0 {
                        //                            // left
                        //                            //                            print("left")
                        //                        }
                        //                        if value.translation.width > 0 {
                        //                            // right
                        //                            //                            print("right")
                        //                        }
                        //                        if value.translation.height < 0 {
                        //                            // up
                        //                            //                            print("up")
                        //                            if inputMemo.count > 0 {
                        //                                withAnimation(.easeInOut(duration: 0.1)) {
                        //                                    memoHeight = 96
                        //                                    imageY = -100
                        //                                }
                        //                            }
                        //                        }
                        //                        if value.translation.height > 0 {
                        //                            // down
                        //                            //                            print("down")
                        //                            withAnimation(.easeInOut(duration: 0.1)) {
                        //                                memoHeight = 44
                        //                                imageY = 0
                        //                            }
                        //                        }
                        //                    }))
                        .keyboardAdaptive(bottomInset: UIApplication.shared.windows[0].safeAreaInsets.bottom)
                        
                        // bottom tab bar
                        DetailBottomTabBar(infoSheet: $infoSheet, ImageStorage: ImageStorage, index: $selectedImageIndex)
                        Color.white
                            .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: UIApplication.shared.windows[0].safeAreaInsets.bottom)
                    } // vstack2
                    .edgesIgnoringSafeArea(.bottom)
                } // isonlyview
                .onAppear(perform: {
                    inputMemo = ImageStorage.imageItems[index].image.memo ?? ""
                })
                .onChange(of: index, perform: { newValue in
    //                isInputMemo = false
                    beforeMemoLen = (ImageStorage.imageItems[newValue].image.memo ?? "").count
                    inputMemo = ImageStorage.imageItems[newValue].image.memo ?? ""
                })
                .customBottomSheet(isPresented: $infoSheet, title: "파일정보") {
                    AnyView(
                        VStack(spacing: 10){
                            HStack(spacing: 0){
                                CustomText(text: "파일명", size: 16, color: .black, weight: .semibold)
                                    .opacity(0.6)
                                    .frame(maxWidth: 80, maxHeight: 44)
                                CustomText(text: ImageStorage.imageItems[index].image.name ?? "", size: 16, color: .black)
                                Spacer()
                                
                            }
                            HStack(spacing: 0){
                                CustomText(text: "해상도", size: 16, color: .black, weight: .semibold)
                                    .opacity(0.6)
                                    .frame(maxWidth: 80, maxHeight: 44)
                                CustomText(text: "\(ImageStorage.imageItems[index].image.width)x\(ImageStorage.imageItems[index].image.height)", size: 16, color: .black)
                                Spacer()
                                
                            }
                            HStack(spacing: 0){
                                CustomText(text: "파일크기", size: 16, color: .black, weight: .semibold)
                                    .opacity(0.6)
                                    .frame(maxWidth: 80, maxHeight: 44)
                                CustomText(text: String(fileSizeToStr(bytes: ImageStorage.imageItems[index].image.size)), size: 16, color: .black)
                                Spacer()
                                
                            }
                            HStack(spacing: 0){
                                CustomText(text: "날짜", size: 16, color: .black, weight: .semibold)
                                    .opacity(0.6)
                                    .frame(maxWidth: 80, maxHeight: 44)
                                CustomText(text: "\(dateToStr(inputDate:  ImageStorage.imageItems[index].image.createdAt))", size: 16, color: .black)
                                Spacer()
                                
                            }
                            
                        }
                    )
                }
                .zIndex(3)
                //            }// zstack
                .ignoresSafeArea(.all)
            }
        }
    } // body
}

struct ImageHStack: View {
    @GestureState var selectedImageOffset: CGSize
    @Binding var didFinishClosingImage: Bool
    @Binding var showFSV: Bool
    @Binding var selectedImageIndex: Int?
    @Binding var selectedImageScale: CGFloat
    @Binding var isSwiping: Bool //.
    @Binding var isSelecting: Bool // 현재 디테일상태인지
    
    public var eventImages: [ImageItem]
    public let geoWidth: CGFloat
    public let geoHeight: CGFloat
    public let namespace: Namespace.ID
    
    
    @State private var backgroundOpacity: CGFloat = 1
    
    @State var scale: CGFloat = 1
    
    var body: some View {
        if self.showFSV, let index = self.selectedImageIndex {
            LazyHStack(spacing: 0) {
                ForEach(eventImages) { item in
                    //                Image(uiImage: UIImage(data: item.image.data!)!)
                    //                Color.red
                    Image(uiImage: item.real_image)
                        .resizable()
                        .zoomable(scale: $scale)
                        .if(eventImages.firstIndex(of: item) == selectedImageIndex && isSelecting, transform: { view in
                            view
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: true)
                        })
                            
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geoWidth, height: geoHeight, alignment: .center)
                            .scaleEffect(isSwiping ? 0.98 : 1.0)
                            .scaleEffect(eventImages.firstIndex(of: item) == selectedImageIndex ? selectedImageScale : 1)
                            .offset(x: (CGFloat(index) * -geoWidth))
                            .offset(selectedImageOffset)
                            .opacity(eventImages.firstIndex(of: item) != selectedImageIndex && selectedImageOffset.height > 10 ? 0 : 1)
                }
            }
            .ignoresSafeArea()
            .background(
                Color.background
                    .opacity(backgroundOpacity)
            )
            .animation(.easeOut(duration: 0.25), value: selectedImageOffset.width)
            .highPriorityGesture(
                DragGesture()
                    .onChanged({ value in
                        DispatchQueue.main.async {
                            if !self.isSelecting && (value.translation.width > 5 || value.translation.width < -5) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.isSwiping = true
                                }
                            }
                            if !self.isSwiping && (value.translation.height > 5 || value.translation.height < -5) {
                                self.isSelecting = true
                            }
                        }
                    })
                    .updating(self.$selectedImageOffset, body: { value, state, _ in
                        if self.isSwiping {
                            state = CGSize(width: value.translation.width, height: 0)
                        } else if self.isSelecting {
                            state = CGSize(width: value.translation.width, height: value.translation.height)
                        }
                    })
                    .onEnded({ value in
                        DispatchQueue.main.async {
                            self.isSwiping = false
                            if value.translation.height > 150 && self.isSelecting {
                                withAnimation(.interactiveSpring()) {
                                    self.didFinishClosingImage = false
                                    self.showFSV = false
                                    self.selectedImageIndex = nil
                                    self.isSelecting = false
                                }
                            } else {
                                self.isSelecting = false
                                let offset = value.translation.width / geoWidth*6
                                if offset > 0.5 && self.selectedImageIndex ?? 0 > 0 {
                                    self.selectedImageIndex! -= 1
                                } else if offset < -0.5 && self.selectedImageIndex ?? 0 < (eventImages.count - 1) {
                                    self.selectedImageIndex! += 1
                                }
                            }
                        }
                    })
            )
            .onChange(of: selectedImageOffset) { imageOffset in
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        switch imageOffset.height {
                        case 50..<70:
                            backgroundOpacity = 0.8
                        case 70..<90:
                            backgroundOpacity = 0.6
                        case 90..<110:
                            backgroundOpacity = 0.4
                        case 110..<130:
                            backgroundOpacity = 0.2
                        case 130..<1000:
                            backgroundOpacity = 0.0
                        default:
                            backgroundOpacity = 1.0
                        }
                    }
                    
                    let progress = imageOffset.height / geoHeight
                    if 1 - progress > 0.5 {
                        selectedImageScale = 1 - progress
                    }
                }
            }
            .onDisappear {
                didFinishClosingImage = true
            }
            .zIndex(2)
        }
    }
}
