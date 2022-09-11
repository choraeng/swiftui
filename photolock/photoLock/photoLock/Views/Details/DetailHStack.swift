//
//  DetailHStack.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/10.
//

// https://stackoverflow.com/questions/71087381/swiftui-matched-geometry-effect-not-working-with-multiple-foreachs

import SwiftUI

struct DetailHStack: View {
    @EnvironmentObject var viewModel: CoreDataViewModel

    var images: [Image] {
        viewModel.itemEntities.map({ item in
            Image(uiImage: UIImage(data: item.image!.data!)!)})
    }
    
//    let width: CGFloat
//    let height: CGFloat
    
    @Binding var selectedImage: UUID?
    var ns: Namespace.ID
        
    init(selectedImage: Binding<UUID?>, ns: Namespace.ID) {
        self._selectedImage = selectedImage
        self.ns = ns
        // initialize selctedTab to selectedImage
        self._selectedTab = State(initialValue: selectedImage.wrappedValue ?? UUID())
    }
    
    @State var selectedTab: UUID
    
    var body: some View {
        //MARK: - Tabview
        TabView(selection: $selectedTab) {
            ForEach(0..<viewModel.itemEntities.count) { idx in
                let item = viewModel.itemEntities[idx]
                let image = Image(uiImage: UIImage(data: item.image!.data!)!)
                
                image
                    .resizable()
                    .scaledToFit()
//                    .matchedGeometryEffect(id: item.id! == selectedTab ? selectedTab : UUID(),
//                                           in: ns, isSource: true)
                    .tag(item.id!)
                    .onTapGesture {
                        withAnimation {
                            selectedImage = nil
                        }
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(Color.black)
        //MARK: - hstack
        //        LazyHStack(spacing: 0) {
        //            ForEach(0..<images.count) { idx in
        //                images[idx]//Image(uiImage: UIImage(data: images[idx].image!.data!)!)
        //                    .resizable()
        //                    .aspectRatio(contentMode: .fit)
        //                    .frame(width: width, height: height, alignment: .center)
        //                    .offset(x: (CGFloat(index) * -width))
        //                    .offset(selectedImageOffset)
        ////                Color.blue
        //            }
        //        }
        //        .ignoresSafeArea()
        //        .background(
        //            Color.black
        //                .opacity(1.0)//backgroundOpacity)
        //        )
        //                .highPriorityGesture(
        //                    DragGesture()
        //                        .onChanged({ value in
        //        //                    DispatchQueue.main.async {
        //        //                        if (value.translation.width > 5 || value.translation.width < -5) {
        //        //                            withAnimation(.easeInOut(duration: 0.2)) {
        //        //                                self.isSwiping = true
        //        //                            }
        //        //                        }
        //        //                        if !self.isSwiping && (value.translation.height > 5 || value.translation.height < -5) {
        //        //                            self.isSelecting = true
        //        //                        }
        //        //                    }
        //                        })
        //                        .updating(self.$selectedImageOffset, body: { value, state, _ in
        //        //                    if self.isSwiping {
        //                                state = CGSize(width: value.translation.width, height: 0)
        //        //                    } else if self.isSelecting {
        //        //                        state = CGSize(width: value.translation.width, height: value.translation.height)
        //        //                    }
        //                        })
        //                        .onEnded({ value in
        //                            DispatchQueue.main.async {
        //                                let offset = value.translation.width / width*6
        //                                if offset > 0.5 && self.index > 0 {
        //                                    self.index -= 1
        //                                } else if offset < -0.5 && self.index < (images.count - 1) {
        //                                    self.index += 1
        //                                }
        //                            }
        //                        })
        //                )
    }
}
