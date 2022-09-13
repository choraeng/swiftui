//
//  DetailHStack.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/10.
//

// https://stackoverflow.com/questions/71087381/swiftui-matched-geometry-effect-not-working-with-multiple-foreachs

import SwiftUI


struct DetailHStack: View {
    var images: [Image]
    var ids: [UUID]
    let width: CGFloat
    let height: CGFloat
    
    @Binding var selectedImage: Int?
    var ns: Namespace.ID
    @GestureState var selectedImageOffset: CGSize
    
    @EnvironmentObject var viewModel: CoreDataViewModel
    
    //    init(images: [Image], ids: [UUID],
    //         width: CGFloat, height: CGFloat,
    //         selectedImage: Binding<Int?>, ns: Namespace.ID, blur: Binding<Bool>) {
    //        self.images = images
    //        self.ids = ids
    //        self.width = width
    //        self.height = height
    //        //        self.items = items
    //        self._selectedImage = selectedImage
    //        self.ns = ns
    //        self._blur = blur
    //        // initialize selctedTab to selectedImage
    ////        self._selectedTab = State(initialValue: selectedImage.wrappedValue ?? UUID())
    //    }
    
    //    @State var selectedTab: UUID
    
    var body: some View {
        //MARK: - Tabview
        //        TabView(selection: $selectedTab) {
        //            ForEach(0..<images.count) { idx in
        ////        let idx = 5
        //                ZStack{
        //                    images[idx]
        //                        .resizable()
        ////                        .matchedGeometryEffect(id: ids[idx] == selectedTab ? selectedTab : UUID(), in: ns)
        //                        .matchedGeometryEffect(id: ids[idx] == selectedTab ? selectedTab : UUID(),
        //                                                                   in: ns, isSource: true)
        //                        .aspectRatio(contentMode: .fit)
        //                        .onAppear {
        //                            print("full", idx, selectedTab, ids[idx] == selectedTab)
        ////                            selectedImage = selectedTab
        //                        }
        //                        .onTapGesture {
        //                            withAnimation(.interpolatingSpring(stiffness: 300, damping: 20)) {
        //                                selectedImage = nil
        //                            }
        //                        }
        //                }
        //                .tag(ids[idx])
        ////                .if(ids[idx] == selectedTab) { content in
        ////                    content.matchedGeometryEffect(id: selectedTab, in: ns)
        ////                }
        //            }
        //
        //        }
        //        .tabViewStyle(.page(indexDisplayMode: .never))
        //MARK: - hstack
        //        ScrollView(.horizontal){
        if let index = self.selectedImage {
            LazyHStack(spacing: 0) {
                ForEach(0..<images.count) { idx in
                    
                    images[idx]
                        .resizable()
                        .if(idx == index, content: { content in
                            content
                                .matchedGeometryEffect(id: ids[idx], in: ns)
                        })
                            .aspectRatio(contentMode: .fit)
                            .frame(width: width, alignment: .center)
                            .offset(x: (CGFloat(index) * -width))
                            .offset(selectedImageOffset)
                    //                        .statusBar(hidden: true)
                }
            }
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 20)) {
                    selectedImage = nil
                }
            }
            
            //        }
            .highPriorityGesture(
                DragGesture()
                    .updating(self.$selectedImageOffset, body: { value, state, _ in
                        state = CGSize(width: value.translation.width, height: value.translation.height)
                    })
            )
        }
    }
}
