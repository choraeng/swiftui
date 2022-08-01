//
//  ResetPasswordView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import SwiftUI

struct ResetPasswordView: View {
    // view 관련
    var titles: [String] = ["기존 비밀번호 입력", "새로운 비밀번호 설정", "새로운 비밀번호 확인"]
    var subtitles: [String] = ["기존에 사용하시던 비밀번호를 입력해주세요", "새롭게 변경하실 비밀번호를 입력해주세요", "확인을 위해 비밀번호를 다시 입력해주세요"]
    
    // 넘겨 받는
    @Binding var isPassword: Bool
    @Binding var isShowingSheet: Bool
    
    @State var passwordOpetionSheet: Bool = false
    
    @State var isEnter: Bool = false
    //    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    @ObservedObject var pwmodel: PasswordModel
    
    @State var state = 0
    @State var done = false
    
    @State var left_view_text: String = "test"
    @State var right_view_text: String = "test1"
    
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar(
                content1: {
                    Button(left_view_text){checkNav(idx: 0)}
                },
                content2: {
                    Button(right_view_text){checkNav(idx: 1)}
                    .disabled(pwmodel.type == .string && pwmodel.input_password.count == 0)
                }
            )
            //        NavigationView {
            passwordView(pwmodel: pwmodel, isEnter: $isEnter)
                .padding(.top, 40)
                .onChange(of: pwmodel.result, perform: { newValue in
                    if pwmodel.result == 1 { // 검색, 확인 버튼
                        if pwmodel.target_password == "" { // 저장이냐 아니냐
                            pwmodel.target_password = pwmodel.input_password
                            pwmodel.input_password = ""
                            state += 1
                        } else {
                            if pwmodel.target_password != pwmodel.input_password {
                                pwmodel.isFail = true
                                
                                //                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                //                                impactMed.impactOccurred()
                                let notiMed = UINotificationFeedbackGenerator()
                                notiMed.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                            } else { // 맞출시에
                                if state == 0 {
                                    pwmodel.target_password = ""
                                    pwmodel.input_password = ""
                                    
                                    state += 1
                                }
                                else {
                                    done = true
                                }
                                //                                isPassword = true
                                //                                isShowingSheet = false
                            }
                        }
                        
                        pwmodel.result = 0
                    }
                })
                .toast(isShowing: $done, text: "비밀번호 변경이 완료되었어요."){
                    isPassword = true
                    isShowingSheet = false
                }
            //        }
                .onAppear {
                    pwmodel.title = titles[0]
                    pwmodel.subtitle = subtitles [0]
                    pwmodel.failtext = "비밀번호가 일치하지 않습니다. 다시 입력해주세요"
                    
                    if pwmodel.type == .string {
                        left_view_text = "취소"
                        right_view_text = "확인"
                    }else {
                        left_view_text = ""
                        right_view_text = "취소"
                    }
                }
                .onChange(of: state) { newValue in
                    pwmodel.title = titles[state]
                    pwmodel.subtitle = subtitles[state]
                    
                    if pwmodel.type == .string{
                        if newValue > 1{
                            right_view_text = "저장"
                        } else if newValue < 2 {
                            right_view_text = "다음"
                        }
                    }
                    
                }
                .onChange(of: pwmodel.type) { newValue in
                    //                left_view_text = "Asdfase"
                    if newValue == .string {
                        left_view_text = "취소"
                        right_view_text = "다음"
                    }else {
                        left_view_text = ""
                        right_view_text = "취소"
                    }
                }
        } // vstack
    }
    
    func checkNav(idx: Int) {
        if idx == 0 && pwmodel.type == .string { // 왼쪽 버튼
            if state > 1 {
                state -= 1
                pwmodel.input_password = ""
                pwmodel.isFail = false
                pwmodel.target_password = ""
            }else {
                isShowingSheet = false
            }
        }else if idx == 1 { // 오른쪽 버튼
            if pwmodel.type == .string { // 문자열 입력
                if state == 0 {
                    if pwmodel.target_password != pwmodel.input_password {
                        pwmodel.isFail = true
                        
                        //                                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                        //                                        impactMed.impactOccurred()
                        let notiMed = UINotificationFeedbackGenerator()
                        notiMed.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                    } else { // 맞출시에
                        state += 1
                    }
                }else if state == 1 {
                    pwmodel.target_password = pwmodel.input_password
                    pwmodel.input_password = ""
                    state += 1
                } else {
                    if pwmodel.target_password != pwmodel.input_password {
                        pwmodel.isFail = true
                        
                        //                                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                        //                                        impactMed.impactOccurred()
                        let notiMed = UINotificationFeedbackGenerator()
                        notiMed.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
                    } else { // 맞출시에
                        
                        done = true
                        //                                isPassword = true
                        //                                isShowingSheet = false
                    }
                }
            }else { // 숫자 입력
                if state > 1 {
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
}
