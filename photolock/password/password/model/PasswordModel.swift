//
//  PasswordModel.swift
//  password
//
//  Created by 조영훈 on 2021/10/18.
//

import Foundation

class PasswordModel: ObservableObject {
    @Published var title: String // 맨 위 텍스트
    @Published var subtitle: String // 부연 설명 텍스트
    @Published var failtext: String // 실패시 실패 문구, 넘기자
    
    @Published var result: Int // 페이지 바뀌면 타이틀 등 넘기는 변수가 바뀌어야해서
                             // 0 -> 일반, 1 -> 성공(다음), 2 -> 취소(이전), 3-> 실패
    @Published var type: PasswordOption // 저장 때문에, 비밀번호 옵션
    @Published var input_password: String // 저장 떄문에, 입력 비밀번호
    
//    @State var isSetPwd: Bool // 이거는 그 비밀번호 옵션 버튼 보이는거떄문에
    
    @Published var target_password: String //
    
//    @Published var pwdColor: Color = Color.black
//    @Published var title: String = ""
//    @Published var subtitle: String = ""
//
    init(){
        title = ""
        subtitle = ""
        failtext = ""
        
        result = 0
        
        type = .digit_4
        input_password = ""
        
        target_password = ""
    }
}
