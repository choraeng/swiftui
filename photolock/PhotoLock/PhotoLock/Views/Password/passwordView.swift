//
//  passwordView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import SwiftUI

struct passwordView: View {
    @ObservedObject var pwmodel: PasswordModel
    @Binding var isEnter: Bool // 키보드 return 키

    @State var pwdOptSheet: Bool = false // 옵션 시트
    @State var pwdColor: Color = Color.blue
    
    
    var body: some View {
        VStack {
            Text(pwmodel.title)
                .font(.system(size: 21))
                .padding([.leading, .trailing], 16)
//                .padding(.bottom, 50)
            Text(pwmodel.subtitle)
                .font(.system(size: 16))
                .padding(.top, 20)
                .padding(.bottom, 30)
            
            // sub title
            
            if pwmodel.type == .string {
                _stringfield
            }else {
                _pincodefield
            }
            
            Spacer()
            
            if pwmodel.target_password.count == 0 {
                Button("비밀번호 옵션"){
                    pwdOptSheet.toggle()
                }
                .foregroundColor(Color.blue)
                .padding(.bottom, 24)
                .actionSheet(isPresented: $pwdOptSheet) {
                    ActionSheet(title: Text("비밀번호 옵션"),
                                buttons: [
                                    .default(Text("사용자 지정 비밀번호")){
                                        pwmodel.input_password = ""
                                        pwmodel.type = .string
                                        pwdColor = Color.black
                                    },
                                    .default(Text("4자리 숫자 비밀번호")){
                                        pwmodel.input_password = ""
                                        pwmodel.type = .digit_4
                                    },
                                    .default(Text("6자리 숫자 비밀번호")){
                                        pwmodel.input_password = ""
                                        pwmodel.type = .digit_6
                                    },
                                    .cancel(Text("취소"))])
                }
            }
            if pwmodel.type != .string {
                Keyboard(password: $pwmodel.input_password)
            }
        }
    }
}

extension passwordView {
    // 패스워드 입력 완료시 확인
    // 맞는지 틀린지
    // 0 -> 일반, 1 -> 성공(다음), 2 -> 취소(이전), 3-> 실패
    func check() -> Int{
        if pwmodel.target_password == "" {
            
        }
        return 0
    }
}

extension passwordView {
    var _stringfield: some View {
        Alphanumeric(pwmodel: pwmodel,
                    commit: $isEnter
            )
            .onChange(of: isEnter) { newValue in
                if newValue {
//                    pwmodel.result = check()
                    isEnter = false
                    pwmodel.result = 1
                }
            }
            .onChange(of: pwmodel.input_password, perform: { newValue in
                if newValue.count > 0 {
                    if pwmodel.isFail {
                        pwmodel.isFail = false
                    }
                    pwdColor = Color.blue
                }
                
            })
    }
}

extension passwordView {
    var _pincodefield: some View {
        Pincode(pwmodel: pwmodel,
//                     circleColor: $pwdColor,
//                     failText: $pwmodel.failtext,
                     _len: (pwmodel.type == .digit_4) ? 4 : 6)
            .onChange(of: pwmodel.input_password) { newValue in
                if pwmodel.isFail {
                    let temp = newValue.last!
                    pwmodel.input_password = "\(temp)"
                    
                    pwmodel.isFail = false
                }
                let _len = (pwmodel.type == .digit_4) ? 4 : 6
                if newValue.count == _len {
//                    pwmodel.result = check()
                    pwmodel.result = 1
                }
            }
    }
}
