//
//  KeyboardView.swift
//  password
//
//  Created by 조영훈 on 2021/10/18.
//

import SwiftUI

//class KeyboardButton {
//    @State var test: String
//    @State var key: String = ""
//
//
//}

struct keyView: View {
    var key: String
    @Binding var password: String
    
    var body: some View {
        Button(action: {
            password += key
        }) {
                Color.clear
                    .overlay(Rectangle()
                            .fill(.clear))
                    .overlay(Text(key)
                            .font(.system(size: 25))
                            .accentColor(.primary))
                }
        .frame(height: 48)
    }
}

struct keyrowView: View {
    var keys: [String]
    @Binding var password: String
    
    var body: some View {
        HStack {
            keyView(key: keys[0], password: $password)
            Spacer()
            keyView(key: keys[1], password: $password)
            Spacer()
            keyView(key: keys[2], password: $password)
        }
    }
}

struct KeyboardView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var password: String
    @State var keys: [String] = []
    
    init(password: Binding<String>) {
        var temp_keys = [String]()
        for i in 0..<10 {
            temp_keys.append("\(i)")
        }
        temp_keys.shuffle()
        
        _keys = State(initialValue: temp_keys)
        
        _password = password
    }
    
    var body: some View {
        VStack{
            ForEach(0..<3) { i in
                keyrowView(keys: Array(keys[(i*3)...(i*3+3)]), password: $password)
            }
            HStack{
                Button(action: { keys.shuffle() }) {
                    Color.clear
                        .overlay(Rectangle()
                                    .fill(.clear))
                        .overlay(Image("reload")
                                    .renderingMode(.template)
                                    .accentColor(.primary))
                        }
                .frame(height: 48)
                
                Spacer()

                keyView(key: keys.last ?? "", password: $password)
                
                Spacer()
                
                Button(action: {
                    if !password.isEmpty {
                        let _ = password.popLast()
                    }
                }) {
                    Color.clear
                        .overlay(Rectangle()
                                    .fill(.clear))
                        .overlay(Image("backspace.left")
                                    .renderingMode(.template)
                                    .accentColor(.primary))
                        }
                .frame(height: 48)
                

            }
        }
        .padding([.leading, .trailing], 25)
        .padding(.bottom, 80)
    }
}
