//
//  passwordView.swift
//  password
//
//  Created by 조영훈 on 2021/10/25.
//

import SwiftUI
//import AlertToast

enum PasswordOption {
    case digit_4
    case digit_6
    case string
}			


struct passwordView: View {
//    @State var title: String // 맨 위 텍스트
//    @State var subtitle: String // 부연 설명 텍스트
//    @State var failtext: String // 실패시 실패 문구, 넘기자
//
//    @Binding var result: Int // 페이지 바뀌면 타이틀 등 넘기는 변수가 바뀌어야해서
//                             // 0 -> 일반, 1 -> 성공(다음), 2 -> 취소(이전), 3-> 실패
//    @Binding var type: PasswordOption // 저장 때문에, 비밀번호 옵션
//    @Binding var input_password: String // 저장 떄문에, 입력 비밀번호
//
//    @State var isEnter: Bool = false // 키보드 return 키
    @Binding var isEnter: Bool // 키보드 return 키
//
////    @State var isSetPwd: Bool // 이거는 그 비밀번호 옵션 버튼 보이는거떄문에
    @State var pwdOptSheet: Bool = false // 옵션 시트
//
//    @Binding var temp_password: String // 이걸로 비밀번호 옵션 버튼 유무 결정
//                                       // count 있으면 패스워드 일치, 없으면 setpw
//
    @State var pwdColor: Color = Color.blue
    @ObservedObject var pwmodel: PasswordModel
    
//    var password: String = "" // 기존 설정된 패스워드 . 앞의 뷰에서 처리
    
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
                .foregroundColor(GlobalValue.option_color)
                .padding(.bottom, 24)
                .actionSheet(isPresented: $pwdOptSheet) {
                    ActionSheet(title: Text("Password Option"), message: Text("select password type"),
                                buttons: [
                                    .default(Text("Custom Alphanumeric Code")){
                                        pwmodel.input_password = ""
                                        pwmodel.type = .string
                                        pwdColor = Color.black
                                    },
                                    .default(Text("4-Digit Numeric Code")){
                                        pwmodel.input_password = ""
                                        pwmodel.type = .digit_4
                                    },
                                    .default(Text("6-Digit Numeric Code")){
                                        pwmodel.input_password = ""
                                        pwmodel.type = .digit_6
                                    },
                                    .cancel(Text("Cancel"))])
                }
            }
            if pwmodel.type != .string {
                KeyboardView(password: $pwmodel.input_password)
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
        StringField(pwmodel: pwmodel,
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
        PincodeField(pwmodel: pwmodel,
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
