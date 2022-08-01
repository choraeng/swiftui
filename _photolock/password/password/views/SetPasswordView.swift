//
//  passwordView.swift
//  password
//
//  Created by 조영훈 on 2021/10/02.
//

import SwiftUI
import Foundation
//import AlertToast


struct SetPasswordView: View {
    // view 관련
    var titles: [String] = ["새로운 비밀번호 설정", "새로운 비밀번호 확인"]
    var subtitles: [String] = ["비밀번호를 입력해주세요", "확인을 위해 비밀번호를 다시 입력해주세요"]
    
    // 넘겨 받는
    @Binding var isPassword: Bool
    @Binding var isShowingSheet: Bool
    
    @State var temp_password: String = ""
    
    @State var passwordOption: PasswordOption = PasswordOption.digit_4
    @State var passwordOpetionSheet: Bool = false
    
    @State var isEnter: Bool = false
//    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    @ObservedObject var pwmodel: PasswordModel
    
    @State var state = 0
    @State var done = false
    
    
    
    var body: some View {
        NavigationView {
            passwordView(isEnter: $isEnter, pwmodel: pwmodel)
                .onChange(of: pwmodel.result, perform: { newValue in
                    if pwmodel.result == 1 { // 검색, 확인 버튼
                        if pwmodel.target_password == "" { // 저장이냐 아니냐
                            pwmodel.target_password = pwmodel.input_password
                            pwmodel.input_password = ""
                            state += 1
                        } else {
                            if pwmodel.target_password != pwmodel.input_password {
                                pwmodel.isFail = true
                                
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                            } else { // 맞출시에
                                
                                done = true
//                                isPassword = true
//                                isShowingSheet = false
                            }
                        }
                        
                        pwmodel.result = 0
                    }
                })
                .toolbar {
//                    if pwmodel.type == .string {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if pwmodel.type == .string {
                            Button("취소"){
                                if state > 0 {
                                    state -= 1
                                    pwmodel.input_password = ""
                                    pwmodel.isFail = false
                                    pwmodel.target_password = ""
                                }else {
                                    isShowingSheet = false
                                }
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if pwmodel.type != .string {
                            Button("취소"){
                                if state > 0 {
                                    state -= 1
                                    pwmodel.input_password = ""
                                    pwmodel.isFail = false
                                    pwmodel.target_password = ""
                                }else {
                                    isShowingSheet = false
                                }
                            }
                        } else {
                            if state == 0 {
                                Button("다음") {
                                    pwmodel.target_password = pwmodel.input_password
                                    pwmodel.input_password = ""
                                    state += 1
                                }
                                .disabled(pwmodel.input_password.count == 0)
                            }else {
                                Button("저장") {
                                    if pwmodel.target_password != pwmodel.input_password {
                                        pwmodel.isFail = true
                                        
                                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                        impactMed.impactOccurred()
                                    } else { // 맞출시에
                                        
                                        done = true
        //                                isPassword = true
        //                                isShowingSheet = false
                                    }
                                }
                                .disabled(pwmodel.input_password.count == 0)
                            }
                        }
                    }
                }
                .toast(isShowing: $done, text: "비밀번호 설정이 완료되었어요."){
                    print("done")
                    isPassword = true
                    isShowingSheet = false
                }
        }
        .onAppear(perform: {
            pwmodel.failtext = "비밀번호가 일치하지 않습니다. 다시 입력해주세요"
            pwmodel.title = titles[state]
            pwmodel.subtitle = subtitles[state]
            pwmodel.target_password = ""
        })
        .onChange(of: state) { newValue in
            pwmodel.title = titles[state]
            pwmodel.subtitle = subtitles[state]
        }
        
    }
}
