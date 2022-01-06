//
//  VerifyEmailView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/11.
//

import SwiftUI

struct VerifyEmailView: View {
    @EnvironmentObject var appLockVM: AppLockModel
    @Binding var emailSheet: Bool
    
    @State var isEnter = false
    @State var input_email = ""
    @State var input_verity_code = ""
    
    @State var isVaild = false // 이메일 형식일때 버튼 활성화를 위해서
    @State var isWaiting = false // 이메일 보내고 기달리는지
    @State var isSuccess = false // 이메일 인증
    @State var isSend = false // 메일 보낸 상태, 토스트 띄우게
    @State var isOverWait = false // 이메일 인증 시간 오버
    
    @State var failText = " "
    @State var timerText = ""
    @State var buttonText = ""
    
    @State var title = "이메일 인증"
    @State var subTitle = "이메일을 인증할 경우 비밀번호를 잊어버렸을 때\n재설정을 신속하게 도와드릴 수 있어요."
    
    @State var borderColor = ColorPalette.text_disaled.color
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    /////////////
    ///
    @State var startTime = Date()
    
    @State var left_view_text: String = "test"
    @State var right_view_text: String = "test1"
    
    var body: some View {
        //        NavigationView {
        VStack(spacing: 0){
            NavigationBar(
                content1: {
                    Button(left_view_text){checkNav(idx: 0)}
                },
                content2: {
                    Button(right_view_text){checkNav(idx: 1)}
                    .disabled(input_email.count == 0)
                }
            )
            
            Circle()
                .frame(width: 62, height: 62)
                .foregroundColor(ColorPalette.primary.color)
                .overlay(Image("mail")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .padding(14))
            //                    .padding(.top, 10)
                .padding(.horizontal, 156)
                .padding(.top, 20)
            
            //                    .padding(.top, 10)
            
            Text(title)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(ColorPalette.text_emphasis.color)
                .padding(.horizontal, 16)
                .padding(.top, 20)
            //                .padding(.bottom, 50)
            Text(subTitle)
                .foregroundColor(ColorPalette.text.color)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 66)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .font(.system(size: 16))
                .padding(.top, 20)
            
            //                ZStack() {
            if !isWaiting {
                _sendinputfield
                    .padding(.top, 30)
                    .onChange(of: input_email) { newValue in
                        if newValue.count == 0 {
                            borderColor = ColorPalette.text_disaled.color
                        } else {
                            if isValidEmailFormat(input: newValue) {
                                isVaild = true
                                failText = " "
                                borderColor = ColorPalette.primary.color
                            }else {
                                isVaild = false
                                failText = "올바른 이메일 형식이 아닙니다. 다시 입력해주세요."
                                borderColor = ColorPalette.status_error.color
                            }
                        }
                    }
                    .onChange(of: isEnter) { newValue in
                        if newValue && isVaild{
                            hideKeyboard()
                            
                            title = "인증 코드 입력"
                            subTitle = "입력하신 이메일로 인증코드를 전송했어요.\n\(input_email)\n인증코드는 5분간 유효하니, 시간 안에 입력해주세요."
                            isWaiting = true
                            isSend = true
                            
                            let date = Date()
                            let date1 = Calendar.current.date(byAdding: .minute, value: 5, to: date)
                            appLockVM.setEmailTime(date: date1 ?? Date(), email: input_email)
                        }
                    }
            } else {
                _sendverifyfield
                    .padding(.top, 30)
                    .onChange(of: input_email) { newValue in
                        if newValue.count == 0 {
                            borderColor = ColorPalette.text_disaled.color
                        } else {
                            if isValidEmailFormat(input: newValue) {
                                isVaild = true
                                failText = " "
                                borderColor = ColorPalette.primary.color
                            }else {
                                isVaild = false
                                failText = "올바른 이메일 형식이 아닙니다. 다시 입력해주세요."
                                borderColor = ColorPalette.status_error.color
                            }
                        }
                    }
                    .onChange(of: isEnter) { newValue in
                        if newValue{
                            ///////////////////////////////////////////
                        }
                    }
            }
            //                        .padding(.top, -10)
            
            //                    Spacer()
            HStack() {
                Text(failText)
                    .foregroundColor(ColorPalette.status_error.color)
                    .font(.system(size: 13))
                    .padding(.top, 8)
                    .padding(.leading, 32)
                Spacer()
            } // HStack
            
            if !isWaiting {
                Button(buttonText) {
                    hideKeyboard()
                    
                    title = "인증 코드 입력"
                    subTitle = "입력하신 이메일로 인증코드를 전송했어요.\n\(input_email)\n인증코드는 5분간 유효하니, 시간 안에 입력해주세요."
                    isWaiting = true
                    isSend = true
                    
                    let date = Date()
                    let date1 = Calendar.current.date(byAdding: .minute, value: 5, to: date)
                    appLockVM.setEmailTime(date: date1 ?? Date(), email: input_email)
                }
                .buttonStyle(PrimaryButton(condition: isVaild))
                .disabled(!isVaild)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            } else {
                Button(buttonText) {
//                    ClickSendBtn()
                }
                .buttonStyle(PrimaryButton(condition: input_verity_code.count != 0))
                .disabled(input_verity_code.count == 0)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
            
            
            Spacer()
            if isWaiting {
                Button ("인증코드를 받지 못했나요?") {
                    //                    pwdOptSheet.toggle()
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(ColorPalette.primary.color)
                .padding(.bottom, 17)
            }
        } // vstack
        .toast(isShowing: $isSend, text: "이메일로 전송을 완료했어요.") {
            isSend = false
        }
//        .navigationTitle(Text(""))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("취소") {
                    emailSheet = false
                }
            }
        }// toolbar
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            appLockVM.getEmailTime()
            if appLockVM.emailTime < Date() {
                buttonText = "인증 코드 전송"
            }else {
                buttonText = "인증 코드 확인"
                title = "인증 코드 입력"
                subTitle = "입력하신 이메일로 인증코드를 전송했어요.\n\(appLockVM.sendedEmail)\n인증코드는 5분간 유효하니, 시간 안에 입력해주세요."
                isWaiting = true
            }
        }
        //        } // navigationview
    } // var body
    
    func isValidEmailFormat(input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input)
    } // func isValidEmailFormat
    
    func clean() {
        input_email = ""
        failText = " "
    } // func clean
    
    func checkNav(idx: Int) {
        
    }
}

extension VerifyEmailView {
    var _sendinputfield: some View {
        ZStack (alignment: .trailing) {
            EmailTextField(
                text: $input_email,
                isFirstResponder: true,
                commit: $isEnter)
                .disableAutocorrection(true)
                .frame(height: 48.0)
            //            .padding([.top, .bottom], 16)
                .padding(.horizontal, 32)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 1)
                            .padding(.horizontal, 16)
                )
                .onChange(of: isEnter) { newValue in
                    if newValue {
                        //                    pwmodel.result = check()
                        isEnter = false
                        //                    pwmodel.result = 1
                    }
                }
            if input_email.count > 0{
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color(.systemGray3))
                    .padding(.trailing, 35)
                    .onTapGesture {
                        withAnimation {
                            self.clean()
                        }
                    }
            }
        }
    }
}

struct EmailTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var commit: Bool
        var didBecomeFirstResponder = false
        
        init(text: Binding<String>, commit: Binding<Bool>) {
            _text = text
            _commit = commit
        }
        
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            commit.toggle()
            return true
        }
        
    }
    
    @Binding var text: String
    var isFirstResponder: Bool = false
    @Binding var commit: Bool
    
    func makeUIView(context: UIViewRepresentableContext<EmailTextField>) -> UITextField {
        let textField = CustomUITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = "email@address.com"
        
        return textField
    }
    
    func makeCoordinator() -> EmailTextField.Coordinator {
        return Coordinator(text: $text, commit: $commit)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<EmailTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    class CustomUITextField: UITextField {
        //        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //            switch action {
        //            case #selector(UIResponderStandardEditActions.paste(_:)),
        //                #selector(UIResponderStandardEditActions.select(_:)),
        //                #selector(UIResponderStandardEditActions.selectAll(_:)),
        //                #selector(UIResponderStandardEditActions.copy(_:)),
        //                #selector(UIResponderStandardEditActions.cut(_:)),
        //                #selector(UIResponderStandardEditActions.delete(_:)) :
        //
        //                return false
        //            default:
        //                return super.canPerformAction(action, withSender: sender)
        //            }
        //        }
    }
}

extension VerifyEmailView {
    var _sendverifyfield: some View {
        ZStack (alignment: .trailing) {
            VerifyTextField(
                text: $input_verity_code,
                isFirstResponder: true,
                commit: $isEnter)
                .disableAutocorrection(true)
                .frame(height: 48.0)
            //            .padding([.top, .bottom], 16)
                .padding(.horizontal, 32)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 1)
                            .padding(.horizontal, 16)
                )
                .onChange(of: isEnter) { newValue in
                    if newValue {
                        //                    pwmodel.result = check()
                        isEnter = false
                        //                    pwmodel.result = 1
                    }
                }
            
            if !isOverWait {
                Text(timerText)
                    .padding(.trailing, 32)
                    .foregroundColor(ColorPalette.primary.color)
                    .font(.system(size: 16))
                    .onReceive(timer) { _ in
                        if isWaiting {
                            let _now = Date()
                            appLockVM.getEmailTime()
                            let dif_time = Int(appLockVM.emailTime.timeIntervalSince(_now))
                            if dif_time <= 0 {
                                isOverWait = true
                            } else {
                                timerText = "\(String(format: "%02d", (dif_time / 60))):\(String(format: "%02d", (dif_time % 60)))"
                            }
                        }
                    }
            } else {
                Button("재전송"){
                    hideKeyboard()
                    
                    title = "인증 코드 입력"
                    subTitle = "입력하신 이메일로 인증코드를 전송했어요.\n\(input_email)\n인증코드는 5분간 유효하니, 시간 안에 입력해주세요."
                    input_verity_code = ""
                    isWaiting = true
                    isSend = true
                    
                    let date = Date()
                    let date1 = Calendar.current.date(byAdding: .minute, value: 5, to: date)
                    appLockVM.setEmailTime(date: date1 ?? Date(), email: input_email)
                    isOverWait.toggle()
                }
                .foregroundColor(ColorPalette.primary.color)
                .padding(.trailing, 32)
                .font(.system(size: 16))
            }
        }
    }
}

struct VerifyTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var commit: Bool
        var didBecomeFirstResponder = false
        
        init(text: Binding<String>, commit: Binding<Bool>) {
            _text = text
            _commit = commit
        }
        
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            commit.toggle()
            return true
        }
        
    }
    
    @Binding var text: String
    var isFirstResponder: Bool = false
    @Binding var commit: Bool
    
    func makeUIView(context: UIViewRepresentableContext<VerifyTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = "Code"
        textField.keyboardType = .numberPad
        
        return textField
    }
    
    func makeCoordinator() -> VerifyTextField.Coordinator {
        return Coordinator(text: $text, commit: $commit)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<VerifyTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
//            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

//
//struct VerifyEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerifyEmailView()
//    }
//}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct EmailHelpView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("인증코드를 받지 못했나요?")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(ColorPalette.text_emphasis.color)
                .padding(.top, 20)
            
            Text("아래의 체크리스트를 확인해보세요")
                .foregroundColor(ColorPalette.text.color)
                .font(.system(size: 16))
                .padding(.top, 10)
                .padding(.bottom, 30)
            
            EmailHelpBox(_text: Text("휴지통과 스팸 메일함").bold() + Text("을 확인해보세요."))
                .padding(.bottom, 10)
            
            EmailHelpBox(_text: Text("인증코드를 받을 때 까지 ") + Text("1~5분이 소요").bold() + Text("될 수 있어요."))
                .padding(.bottom, 10)
            
            EmailHelpBox(_text: Text("입력하신 이멩이로 인증코드를 받을 수\n업다면") + Text("재전송 버튼").bold() + Text("을 눌러 다시 요청해보세요."))
                .padding(.bottom, 10)
            
            EmailHelpBox(_text: Text("잘못된 이메일").bold() + Text("을 입력했을 수 있습니다.\n이전 단계로 돌아가 이메일을 다시 입력해보세요."))
                .padding(.bottom, 10)
            
            Spacer()
            
        }
        .padding(.horizontal, 16)
    }
}

struct EmailHelpBox: View {
    var _text: Text
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Image("check_icon")
                    .frame(width: 24, height: 24)
                    .padding(.horizontal, 16)
                
                _text
                
                Spacer()
            }
        }
        .frame(height: 90)
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.975, green: 0.975, blue: 0.975))
        .cornerRadius(10)
        
    }
}
//
//
//struct EmailHelpView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailHelpView()
//    }
//}
//
