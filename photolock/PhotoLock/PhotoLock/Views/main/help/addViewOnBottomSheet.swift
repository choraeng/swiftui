//
//  albumAdd.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/02.
//

import SwiftUI

struct addViewOnBottomSheet: View {
    var addType: String
    
    @State var inputText: String = ""
    //    @State var isCommit = false
    
    @State var extendToggle = false
    @State var setPasswrdToggle = false
    
    @State var extendViewOpacity:Double = 0
    
    var body: some View {
        VStack(spacing: 18) {
            TextField("\(addType) 이름을 입력하세요.", text: $inputText, onCommit: {
                //                    isCommit.toggle()
            })
                .frame(maxWidth: .infinity, maxHeight: 48)
                .padding(.horizontal, 16)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.761, green: 0.761, blue: 0.761), lineWidth: 1)
                )
            Button {
                if !extendToggle {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            extendViewOpacity = 1
                        }
                    }
                }else {
                    withAnimation(.linear(duration: 0.01)) {
                        extendViewOpacity = 0
                    }
                }
                withAnimation() {
                    extendToggle.toggle()
                }
            } label: {
                HStack(spacing: 16) {
                    Image("side_right")
                        .rotationEffect(Angle.degrees(extendToggle ? 90 : 0))
                        .animation(.default)
                    
                    Text("\(addType) 설정")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                        .bold()
                    
                    Spacer()
                }
            }
            
            if extendToggle {
                Button {
                    
                } label: {
                    HStack {
                        Text("커버이미지 설정")
                            .padding(.leading, 56)
                            .font(.system(size: 16))
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color.gray)
                    }
                }
                .opacity(extendViewOpacity)
                
                Button {
                    setPasswrdToggle.toggle()
                } label: {
                    HStack {
                        Text("비밀번호 설정")
                            .padding(.leading, 56)
                            .font(.system(size: 16))
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        Toggle(isOn: $setPasswrdToggle) {
                            
                        }
                    }
                }
                .opacity(extendViewOpacity)
            } // if extended
            
            Button("저장") {
//                    ClickSendBtn()
            }
            .buttonStyle(PrimaryButton(condition: inputText.count != 0))
//            .disabled(input_verity_code.count == 0)
        } // vstack
    }
}
