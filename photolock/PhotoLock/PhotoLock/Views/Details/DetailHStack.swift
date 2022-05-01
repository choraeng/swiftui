//
//  DetailHStack.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct ImageHStack: View {
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
    
    @State var scale: CGFloat = 1
    
//    @EnvironmentObject var ItemStorage: ItemEntityStorage
    
    var images: [Image]
    var ids: [UUID]
    
    
    
    var body: some View {
        if self.showFSV, let index = self.selectedImageIndex {
            LazyHStack(spacing: 0) {
                ForEach(0..<images.count) { idx in
                    //                Image(uiImage: UIImage(data: item.image.data!)!)
                    //                Color.red
                    //                    Image(uiImage: item.real_image)
                    images[idx]
                        .resizable()
                    //                        .zoomable(scale: $scale)
                        .if(idx == selectedImageIndex && isSelecting, transform: { view in
                            view
                                .matchedGeometryEffect(id: ids[idx], in: namespace, isSource: true)
                        })
                            
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geoWidth, height: geoHeight, alignment: .center)
                            .scaleEffect(isSwiping ? 0.98 : 1.0)
                            .scaleEffect(idx == selectedImageIndex ? selectedImageScale : 1)
                            .offset(x: (CGFloat(index) * -geoWidth))
                            .offset(selectedImageOffset)
                            .opacity(idx != selectedImageIndex && selectedImageOffset.height > 10 ? 0 : 1)
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
                                } else if offset < -0.5 && self.selectedImageIndex ?? 0 < (images.count - 1) {
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

