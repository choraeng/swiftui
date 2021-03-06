//
//  Keyboard.swift
//  PhotoLock
//
//  Created by ์กฐ์ํ on 2021/11/02.
//

import SwiftUI

struct keyView: View {
    var key: String
    @Binding var password: String
    @Binding var isLock: Bool
    
    var body: some View {
        Button(action: {
            if !isLock {
                password += key
            }else{
            }
        }) {
            Color.clear
                .overlay(Rectangle()
                            .fill(.clear))
                .overlay(
                    CustomText(text: key, size: 25)
                )
        }
        .frame(height: 48)
    }
}

struct keyrowView: View {
    var keys: [String]
    @Binding var password: String
    @Binding var isLock: Bool
    
    var body: some View {
        HStack {
            keyView(key: keys[0], password: $password, isLock: $isLock)
            Spacer()
            keyView(key: keys[1], password: $password, isLock: $isLock)
            Spacer()
            keyView(key: keys[2], password: $password, isLock: $isLock)
        }
    }
}


struct NineNumberKeyboard: View {
    @Binding var password: String
    @State var keys: [String] = []
    @Binding var isLock: Bool
    
    init(password: Binding<String>, lock: Binding<Bool>) {
        var temp_keys = [String]()
        for i in 0..<10 {
            temp_keys.append("\(i)")
        }
        temp_keys.shuffle()
        
        _keys = State(initialValue: temp_keys)
        
        _password = password
        _isLock = lock
    }
    
    var body: some View {
        VStack{
            ForEach(0..<3) { i in
                keyrowView(keys: Array(keys[(i*3)...(i*3+3)]), password: $password, isLock: $isLock)
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
                
                keyView(key: keys.last ?? "", password: $password, isLock: $isLock)
                
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
        .padding(.horizontal, 25)
        .padding(.bottom, 80)
    }
}
