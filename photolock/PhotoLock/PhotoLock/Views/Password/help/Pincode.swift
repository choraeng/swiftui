//
//  Pincode.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import SwiftUI

struct Pincode: View {
//    @ObservedObject var pwmodel: PasswordModel
    
//    @Binding var failText: String
    
    @Binding var input_password: String
    @Binding var isFail: Bool
    @Binding var fail_text: String
    
    
    @State var circleColor: Color = ColorPalette.primary.color
    // 패스워드 관련
//    var _size: Int
    var _len: Int
    
//    @FocusState private var passwordIsFocus: Bool -> ios 15부터 ㅜㅜ

    private func getImageName(at index: Int) -> String {
        if index >= input_password.count {
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
            
            if isFail {
                Text(fail_text)
                    .foregroundColor(ColorPalette.status_error.color)
                    .font(.system(size: 13))
            }
        }
        .onChange(of: isFail) { newValue in
            if newValue {
                circleColor = ColorPalette.status_error.color
            }else {
                circleColor = ColorPalette.primary.color
            }
        }
        .onAppear {
            if isFail {
                circleColor = ColorPalette.status_error.color
            }else {
                circleColor = ColorPalette.primary.color
            }
        }
         
    }
}
