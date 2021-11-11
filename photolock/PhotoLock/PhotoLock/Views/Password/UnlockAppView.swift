//
//  UnlockAppView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/07.
//

import SwiftUI

struct UnlockAppView: View {
    @EnvironmentObject var appLockVM: AppLockModel
    @Environment(\.scenePhase) var scenePhase
    
    // view 관련
    var titles: [String] = ["비밀번호 입력"]
    var subtitles: [String] = ["잠금해제를 위해 비밀번호를 입력해주세요", "입력회수 초과로 잠금되었습니다."]
    var failes: [String] = ["비밀번호가 일치하지 않습니다. 다시 입력해주세요.", "비밀번호 입력 오류가 3번을 초과할 경우 잠금 실행되요 (1/3)", "비밀번호 입력 오류가 3번을 초과할 경우 잠금 실행되요 (2/3)", "이번에 틀릴 경우 잠금됩니다. 신중하게 입력해주세요", ""] // "잠금 해제까지 4:48분 남았어요"]
    
    @State var temp_password: String = ""
    
    @State var passwordOption: PasswordOption = PasswordOption.digit_4
    @State var passwordOpetionSheet: Bool = false
    
    @State var isEnter: Bool = false
    //    @State var currentState: Int = 0 // 0 -> start, 1 -> verify
    
    @ObservedObject var pwmodel = PasswordModel()
    
    @State var fail_cnt = -1
    @State var state = 0
    @State var pwdColor: Color = ColorPalette.primary.color
    
    @State var isLocked = false
    @State var isFail = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(titles[0])
                    .font(.system(size: 21, weight: .bold))
                    .padding([.leading, .trailing], 16)
                //                .padding(.bottom, 50)
                Text(!isLocked ? subtitles[0] : subtitles[1])
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
                
                if pwmodel.type != .string {
                    Keyboard(password: $pwmodel.input_password, lock: $isLocked)
                }
            }
        }
        .onAppear {
            pwmodel.target_password = appLockVM.password
            pwmodel.type = appLockVM.password_type
            
            if Date() < appLockVM.lockTime  {
                isLocked = true
            }
            else {
                if appLockVM.isBio {
    //                appLockVM.appLockValidation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                      appLockVM.appLockValidation {
                          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
    //                          appLockVM.isAppUnlocked = true
    //                          pwmodel.input_password = pwmodel.type == .digit_4 ? "aaaa" : "~~~~~~"
                              pwmodel.input_password = pwmodel.target_password
                          }
                      }
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            let _now = Date()
            if isLocked {
                
                //                let df = DateFormatter()
                //                df.dateFormat = "HH:mm"
                //                let dif = Calendar.current.date(b: .day, value: 1, to: date)
                let dif_time = Int(appLockVM.lockTime.timeIntervalSince(_now))
                if dif_time <= 0 {
                    isLocked = false
                    isFail = false
                    fail_cnt = 0
                } else {
//                    print("잠금 해제까지 \(dif_time / 60):\(dif_time % 60)분 남았어요")
                    pwmodel.failtext = "잠금 해제까지 \(dif_time / 60):\(dif_time % 60)분 남았어요"
                }
            }
        }
    }
}

extension UnlockAppView {
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
                    if isFail {
                        isFail = false
                    }
                    pwdColor = ColorPalette.primary.color
                }
                
            })
    }
}

extension UnlockAppView {
    var _pincodefield: some View {
        Pincode(input_password: $pwmodel.input_password,
                isFail: $isFail,
                fail_text: $pwmodel.failtext,
                _len: (pwmodel.type == .digit_4) ? 4 : 6)
            .onChange(of: pwmodel.input_password) { newValue in
                if !isLocked {
                    let _len = (pwmodel.type == .digit_4) ? 4 : 6
                    
                    if isFail && pwmodel.input_password.count > _len{
                        let temp = newValue.last!
                        pwmodel.input_password = "\(temp)"
                        
                        isFail = false
                    }
                    
                    if newValue.count == _len {
                        //                    pwmodel.result = check()
//                        pwmodel.result = 1
                        if pwmodel.target_password != pwmodel.input_password {
                            fail_cnt += 1
                            if fail_cnt == 4 {
                                pwmodel.failtext = "잠금 해제까지 0:0분 남았어요"
                                isLocked = true
                                // 타이머 설정
                                let date = Date()
                                let date1 = Calendar.current.date(byAdding: .minute, value: 5, to: date)
                                appLockVM.setLockTime(date: date1 ?? Date())
                            }else {
                                pwmodel.failtext = failes[fail_cnt]
                            }
                            isFail = true
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                        } else { // 맞출시에
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                appLockVM.isAppUnlocked = true
                            }
                        }
                    }
                }
            }
    }
}
