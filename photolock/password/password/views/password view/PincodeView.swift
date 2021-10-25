//
//  numberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct PincodeView: View {
    @ObservedObject var pwmodel: PasswordModel

    @State var circleColor: Color = Color.black
    
    // 패스워드 관련
    var pwMaxLen: Int
    
//    @FocusState private var passwordIsFocus: Bool -> ios 15부터 ㅜㅜ

    var body: some View {
        VStack {
            ZStack {
                pinDots
                    .onChange(of: pwmodel.fail) { newValue in
                        if newValue {
                            circleColor = GlobalValue.false_color
                        }else {
                            circleColor = Color.black
                            if !pwmodel.password.isEmpty {
                                pwmodel.password = String(pwmodel.password.last!)
                            }
                        }
                    }
            }
            
            if pwmodel.fail {
                Text("Passcode does not match")
                    .foregroundColor(GlobalValue.false_color)
                    .font(.system(size: 16))
            }
        }
    }
    
    
    var pinDots: some View {
        HStack {
            ForEach(Array(pwmodel.password), id: \.self) {_ in
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16.0, height: 16.0)
                    .foregroundColor(circleColor)
            }
            if pwmodel.password.count <= pwMaxLen {
                ForEach(0..<pwMaxLen-pwmodel.password.count, id: \.self) {_ in
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(circleColor)
                }
            }
        }
        .padding()
    }
}
