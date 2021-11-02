//
//  numberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct PincodeField: View {
    @ObservedObject var pwmodel: PasswordModel
    @State var circleColor: Color = Color.blue
//    @Binding var failText: String
    
    
    
    // 패스워드 관련
//    var _size: Int
    var _len: Int
    
//    @FocusState private var passwordIsFocus: Bool -> ios 15부터 ㅜㅜ

    private func getImageName(at index: Int) -> String {
        if index >= pwmodel.input_password.count {
            return "circle"
        }
        
        return "circle.fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<_len, id: \.self) {idx in
                    Image(systemName: getImageName(at: idx))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(circleColor)
                }
            }
            .padding()
            if pwmodel.isFail {
                Text(pwmodel.failtext)
                    .foregroundColor(GlobalValue.false_color)
                    .font(.system(size: 16))
            }
        }
        .onChange(of: pwmodel.isFail) { newValue in
            if newValue {
                circleColor = GlobalValue.false_color
            }else {
                circleColor = Color.blue
            }
        }
         
    }
}
