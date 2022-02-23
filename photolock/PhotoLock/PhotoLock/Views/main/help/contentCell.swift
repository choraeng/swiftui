//
//  contentCell.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/17.
//

import SwiftUI

struct contentCell: View {
    //    @EnvironmentObject private var imageItem: ImageEntity
    var imageItem: ImageItem
    var isSelectMode: Bool
    
    let ns: Namespace.ID
    @Binding var isView: Bool
    @Binding var pickId: UUID
    
    let idx: Int
    @Binding var currentIndex: Int?
    
    private var image: Image {
        Image(uiImage: imageItem.real_image)//UIImage(data: imageItem.image.data!)!)
    }
    
    var body: some View {
        if !(isView && currentIndex! == idx) {
            Button {
//                print("cell", imageItem.id)
                DispatchQueue.main.async {
                    withAnimation(.easeIn(duration: 0.2)) {
                        currentIndex = idx
                        isView.toggle()
                    }
                }
            } label: {
                ZStack {
//                    Color.blue
//                        .frame(width: 100, height: 100)
//                        .matchedGeometryEffect(id: imageItem.id, in: ns, isSource: isView ? false : true)
                    Color.clear
                        .aspectRatio(1, contentMode: .fit)
                        .background(
                            image
                                .resizable()
                                .matchedGeometryEffect(id: imageItem.id, in: ns, isSource: isView ? false : true)
                                .aspectRatio(contentMode: .fill)
                        )
                        .clipped()
                        
                    // favorite
                    if imageItem.image.isFavorite{
                        itemFavorite()
                    }
                    
                    // check
                    if isSelectMode {
                        Rectangle()
                            .fill(Color.black)
                            .aspectRatio(1, contentMode: .fit)
                            .opacity(0.2)
                        checkCircle()
                    }
                } // zstack
                
            } // button
            .zIndex(0)
        } else {
            Color.clear
        }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // body
}

struct itemFavorite: View {
    
    var body: some View {
        //        ZStack(alignment: .bottomLeading) {
        VStack{
            Spacer()
            HStack{
                Image("favorite")
                    .resizable()
                //                .renderingMode(.template)
                //                .foregroundColor(Color.white)
                //                .background(Color.clear)
                    .frame(width: 24, height: 24)
                Spacer()
            }
        }
        .padding(8)
    }
}

struct checkCircle: View {
    var body: some View {
        VStack{
            HStack{
                ZStack() {
                    
                    //            Circle()
                    //                .strokeBorder(Color.white, lineWidth: 1.5)
                    //                .background(Circle().foregroundColor(Color.clear))
                    //                  .frame(width: 22.5, height: 22.5)
                    
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 1.5)
                        .background(Circle().foregroundColor(.primary))
                        .frame(width: 22.5, height: 22.5)
                    
                    
                    Image("check_icon_rounded")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .background(Color.clear)
                        .frame(width: 10, height: 8)
                }
                .padding(8)
                Spacer()
            }
            Spacer()
        }
    }
}


struct FitToAspectRatio: ViewModifier {
    
    let aspectRatio: Double
    let contentMode: SwiftUI.ContentMode
    
    func body(content: Content) -> some View {
        Color.clear
            .aspectRatio(aspectRatio, contentMode: .fit)
            .overlay(
                content.aspectRatio(nil, contentMode: contentMode)
            )
            .clipShape(Rectangle())
    }
    
}

extension Image {
    func fitToAspect(_ aspectRatio: Double, contentMode: SwiftUI.ContentMode) -> some View {
        self.resizable()
            .scaledToFill()
            .modifier(FitToAspectRatio(aspectRatio: aspectRatio, contentMode: contentMode))
    }
}
