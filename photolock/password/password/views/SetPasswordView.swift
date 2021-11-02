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
    
    @ObservedObject var pwmodel: PasswordModel = PasswordModel()
    
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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("why"){

                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("wn"){

                        }
                    }
                }
//            passwordView(
//
//            )
//            .toast(isPresenting: $isPassword, duration: 1.0, tapToDismiss: true, alert: {
////                AlertToast(type: .complete(Color.green), title: "Done")
//
//                AlertToast(displayMode: .banner(<#T##transition: AlertToast.BannerAnimation##AlertToast.BannerAnimation#>) ,type: .regular, title: "asdfasdf")
//            }, completion: {
//                print("done")
//                isShowingSheet = false
//            })
                .toast(isShowing: $done, text: "비밀번호 설정이 완료되었어요."){
                    print("done")
                    isPassword = true
                    isShowingSheet = false
                }
//            .accentColor(GlobalValue.navigation_color)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    if passwordOption == .string {
//                        if pwmodel.state == 0 {
//                            Button("Cancel") {
//                                isShowingSheet = false
//                            }
//                        }else {
//                            Button("Cancel") {
//                                pwmodel.state = 0
//                                pwmodel.password = ""
//                            }
//                        }
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    if passwordOption != .string {
//                        if pwmodel.state == 0 {
//                            Button("Cancel") {
//                                isShowingSheet = false
//                            }
//                        }else {
//                            Button("Cancel") {
//                                pwmodel.state = 0
//                                pwmodel.password = ""
//                            }
//                        }
//                    } else {
//                        if pwmodel.state == 0 {
//                            Button("Next") {
//                                temp_password = pwmodel.password
//                                pwmodel.password = ""
//                                pwmodel.state = 1
//                            }
//                            .disabled(pwmodel.password.count == 0)
//                        }else {
//                            Button("Done") {
//                                if temp_password == pwmodel.password {
//                                    pwmodel.done = true
//                                }else {
//                                    pwmodel.fail = true
//                                    pwmodel.password = ""
//                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                                    impactMed.impactOccurred()
//                                }
//                            }
//                        }
//                    }
//                }
//            }
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
//
//struct Toast<Presenting>: View where Presenting: View {
//
//    /// The binding that decides the appropriate drawing in the body.
//    @Binding var isShowing: Bool
//    /// The view that will be "presenting" this toast
//    let presenting: () -> Presenting
//    /// The text to show
//    let text: String
//
//    var body: some View {
//
//        GeometryReader { geometry in
//
//            ZStack(alignment: .bottom) {
//
//                self.presenting()
////                    .blur(radius: self.isShowing ? 1 : 0)
//
////                VStack {
//                HStack(spacing: 10) {
//                        Image("select_icon")
//                            .renderingMode(.template)
//                            .foregroundColor(Color.white)
//                            .padding(.leading, 18)
//                        
//                        Text(self.text)
//                            .foregroundColor(Color.white)
//                            .font(.system(size: 13))
//                        
//                        Spacer()
////                    }
////                    .background(Color(red: 0.27, green: 0.287, blue: 1.0, opacity: 0.2))
//                }
//                .frame(width: geometry.size.width - 16*2,
//                       height: 48)
//                .background(Color(red: 0.27, green: 0.287, blue: 0.312, opacity: 0.8))
////                .foregroundColor(Color.primary)
//                .cornerRadius(4)
//                .transition(.slide)
//                .opacity(self.isShowing ? 1 : 0)
////                .padding([.leading, .trailing], 16)
//                .padding(.bottom, 50)
//
//            }
//
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//              withAnimation {
//                self.isShowing = false
//              }
//            }
//        }
//
//    }
//
//}
//
//
//extension View {
//    func toast(isShowing: Binding<Bool>, text: String) -> some View {
//        Toast(isShowing: isShowing,
//              presenting: { self },
//              text: text)
//    }
//}
