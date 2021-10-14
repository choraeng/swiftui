//
//  numberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct numberView: View {
    // 상태 관련
    @Binding var isShowingSheet: Bool
    @Binding var currentState: Int // 0 -> start, 1 -> verify
    @Binding var password: String
    @Binding var isPassword: Bool
    
    @State var verifyFail: Bool = false
    
    @State var first_password: String = ""
    @State var input_password: String = ""
    @State var circleColor: Color = Color.black
    
    // 패스워드 관련
    var pwMaxLen: Int
//    @State var pwInput: String = "" // 사용자 입력 패스워드

    var body: some View {
         
            VStack {
                pwInputFiled
                
                if verifyFail {
                    Text("Passcode does not match")
                        .foregroundColor(Color.red)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if currentState == 0 {
                        Button("Cancel"){
                        isShowingSheet = false
//                            isCancel = true
                        }
                    }else if currentState == 1{
                        Button("Cancel"){
                            currentState = 0
                            input_password = ""
                            circleColor = Color.black
                            verifyFail = false
                        }
                    }
                }
            }
        
    }
    
    var pwInputFiled: some View {
        ZStack {
            pinDots
            backgroundTF
        }
    }
    
    var pinDots: some View {
        HStack {
            ForEach(Array(input_password), id: \.self) {_ in
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16.0, height: 16.0)
                    .foregroundColor(circleColor)
            }
            if input_password.count <= pwMaxLen {
                ForEach(0..<pwMaxLen-input_password.count, id: \.self) {_ in
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
    
    var backgroundTF: some View { // text filed
        SecureField("", text: $input_password)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .keyboardType(.numberPad)
            .onChange(of: input_password) { newValue in
                if verifyFail == true {
                    verifyFail.toggle()
                    circleColor = Color.black
                }
                
                if input_password.count > pwMaxLen{
                    input_password = ""
                }
                
                if input_password.count == pwMaxLen {
                    if currentState == 0{
                        first_password = input_password
                        input_password = ""
                        currentState = 1
                    }else {
                        if first_password == input_password {
                            isPassword = true
                            password = input_password
                        }else {
                            verifyFail = true
                            circleColor = Color.red
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                        }
                    }
                }
            }
    }
}
