//
//  imageVstack.swift
//  modules_test
//
//  Created by 조영훈 on 2022/08/03.
//

import SwiftUI
//import KingfisherSwiftUI
import GridStack

import Foundation

final class ImageData: ObservableObject {
    @Published var photos = [String]()
    
    init(){
        photos = ["unnamed", "unnamed (1)", "unnamed (2)", "unnamed (3)"]
    }
}

struct imageVstack: View {
    @EnvironmentObject var imageData: ImageData
    
    var body: some View {
        NavigationView{
            GridStack(minCellWidth: UIScreen.main.bounds.width/3-20, spacing: 3, numItems: imageData.photos.count) { index, cellWidth in
                NavigationLink(destination: DetailView().environmentObject(ImageCounter.init(index: index))){
                    Image(self.imageData.photos[index])
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationBarTitle("Swipe")
        }
    }
}

struct DetailView: View{
    @EnvironmentObject var imageData: ImageData
    @EnvironmentObject var imageCounter: ImageCounter
    
    @State var isUserSwiping: Bool = false
    @State var offset: CGFloat = 500.0
    
    var body: some View{
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(alignment: .center, spacing: 1){
                    ForEach(self.imageData.photos, id: \.self) { photo in
                        Image(photo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width)
                            .edgesIgnoringSafeArea(.all)
//                            .padding(.leading, -0.5)
                    }
                }
            }
            .content
            .offset(x:self.isUserSwiping ? self.offset : CGFloat(self.imageCounter.id) * -geometry.size.width)
            .frame(width: geometry.size.width, alignment: .leading)
            .animation(.spring())
            .gesture(DragGesture()
                        .onChanged({value in
                self.isUserSwiping = true
                self.offset = value.translation.width - geometry.size.width * CGFloat(self.imageCounter.id)
            })
                        .onEnded({value in
                if (value.translation.width < 0){
                    if value.translation.width < geometry.size.width / 2, self.imageCounter.id < self.imageData.photos.count - 1 {
                        self.imageCounter.id += 1
                    }
                }
                else if (value.translation.width > 0){
                    if value.translation.width > 30.0, self.imageCounter.id > 0{
                        self.imageCounter.id -= 1
                    }
                }
                withAnimation {
                    self.isUserSwiping = false
                }
            })
            )
        }
    }
}


class ImageCounter: ObservableObject{
    @Published var id: Int = 0
    init(index: Int){
        self.id = index
    }
}

struct imageVstack_Previews: PreviewProvider {
    static var previews: some View {
        imageVstack()
    }
}
