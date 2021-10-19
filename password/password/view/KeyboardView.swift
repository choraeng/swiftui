//
//  KeyboardView.swift
//  password
//
//  Created by 조영훈 on 2021/10/18.
//

import SwiftUI

struct KeyboardView: View {
    @State var password = "asdfasdf"
    @State var key: [String] = []
    
    init() {
        for i in 0..<10 {
            key.append("\(i)")
            print(i)
        }
        print(key)
    }
    
    var body: some View {
        VStack{
            Text("asdfasdf")
                .padding()
            Text("asdfasdf")
                .padding()
            
//            ForEach(0..<3) { i in
//                HStack{
//                    ForEach(0..<3){ j in
//                        Text(key[i*3+j])
//                    }
//                }
//            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
