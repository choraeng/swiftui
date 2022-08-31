//
//  ContentView.swift
//  FontTest
//
//  Created by 조영훈 on 2021/11/27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var fontSize: Float = 10
    @State var fontColor: Color = Color.black
    
    @State var text: String = "test"
    
    var body: some View {
        VStack {
            HStack {
                Slider(value: $fontSize,
                       in: 1...100,
                       step: 1
                ) {}
            minimumValueLabel: {Text("1")}
            maximumValueLabel: {Text("100")}
            .padding()
                Text("\(Int(fontSize))")
                    .padding()
            }
//            GroupBox {
                HStack{
                    Text("Input")
                        .padding()
                    TextField("", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
//            }
            
            Text(text)
                .font(.system(size: CGFloat(fontSize)))
        }
    }
} // contentview
