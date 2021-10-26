//
//  numberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct PincodeField: View {
    // @ObservedObject var pwmodel: PasswordModel
    @State var circleColor: Color
    @State var failText: String
    
    
    // 패스워드 관련
    var _size: Int
    var _len: Int
    
//    @FocusState private var passwordIsFocus: Bool -> ios 15부터 ㅜㅜ

    var body: some View {
        VStack {
            HStack {
                ForEach(0..<_size, id: \.self) {_ in
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(circleColor)
                }
                ForEach(0..<_len-_size, id: \.self) {_ in
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(circleColor)
                }
            }
            .padding()
            Text(failText)
                .foregroundColor(GlobalValue.false_color)
                .font(.system(size: 16))
        }
         
    }
}
