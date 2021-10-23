//
//  ContentView.swift
//  GridView
//
//  Created by 조영훈 on 2021/09/18.
//

import SwiftUI
import CoreData
import QGrid

struct Storage: Identifiable {
    var img: String
    let id = UUID()
}

struct GridCell: View {
  var img: String

  var body: some View {
    VStack() {
      Image(img)
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
        .shadow(color: .primary, radius: 5)
        .padding([.horizontal, .top], 7)
      Text(img).lineLimit(1)
//      Text(person.lastName).lineLimit(1)
    }
  }
}

struct ContentView: View {
    @State var imgList = [
        Storage(img: "rainbowlake"),
        Storage(img: "charleyrivers"),
        Storage(img: "stmarylake"),
        Storage(img: "chilkoottrail"),
        Storage(img: "hiddenlake"),
        Storage(img: "icybay"),
        Storage(img: "silversalmoncreek"),
        Storage(img: "lakemcdonald"),
        Storage(img: "chincoteague"),
        Storage(img: "twinlake"),
        Storage(img: "umbagog")
    ]
    
    @State var imgColumns = 3
    
    func setColumns(num: Int){
        imgColumns = num
    }
    
    var numColumns = [
        ("1", 1),
        ("2", 2),
        ("3", 3),
        ("5", 5),
        ("6", 6),
    ]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(numColumns, id: \.0) { value in
                    Button(action: {
                        setColumns(num: value.1)
//                        withAnimation(.easeOut(duration: 1)){
////                        withAnimation(.spring(response: 0.5, dampingFraction: 1.0, blendDuration: 1.0)){
//                            setColumns(num: value.1)
//                        }
                    }) {
                        Text(value.0)
                    }
                }
//                Button("1") {
//                    withAnimation(.easeInOut(duration: 4)){
//                        setColumns(num: 1)
//                    }
//                }
//                Button("3") {
//                    setColumns(num: 3)
//                }
//                Button("6") {
//                    setColumns(num: 6)
//                }
            }
            QGrid(imgList, columns: imgColumns) {
                GridCell(img: $0.img)
            }
                .animation(.easeOut(duration: 1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("3"){
                
            }
            ContentView()
        }
    }
}
