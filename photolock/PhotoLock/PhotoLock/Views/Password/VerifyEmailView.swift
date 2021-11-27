//
//  VerifyEmailView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/11.
//

import SwiftUI

struct VerifyEmailView: View {
    @State var isEnter = false
    @State var input_email = ""
    
    @State var isFail = false // 이메일 형식 아닐떄
    @State var isVaild = false // 이메일 형식일때 버튼 활성화를 위해서
    @State var isWaiting = false // 이메일 보내고 기달리는지
    @State var isSuccess = false // 이메일 인증
    @State var isSend = false // 메일 보낸 상태, 토스트 띄우게
    
    @State var failText = " "
    @State var timerText = ""
    
    @State var title = "이메일 인증"
    @State var subTitle = "이메일을 인증할 경우 비밀번호를 잊어버렸을 때\n재설정을 신속하게 도와드릴 수 있어요."
    
    @State var borderColor = ColorPalette.text_disaled.color
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    /////////////
    ///
    @State var startTime = Date()
    
    var body: some View {
//        NavigationView {
            VStack(spacing: 0){
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
                    .padding([.leading, .trailing], 156)
                
                Text(title)
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(ColorPalette.text_emphasis.color)
                    .padding([.leading, .trailing], 16)
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
                _stringfield
                    .padding(.top, 30)
                    .onChange(of: input_email) { newValue in
                        if newValue.count == 0 {
                            borderColor = ColorPalette.text_disaled.color
                        } else {
                            if isValidEmailFormat(input: newValue) {
                                isVaild = true
                                isFail = false
                                failText = " "
                                borderColor = ColorPalette.primary.color
                            }else {
                                isVaild = false
                                isFail = true
                                failText = "올바른 이메일 형식이 아닙니다. 다시 입력해주세요."
                                borderColor = ColorPalette.status_error.color
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
//                        .onChange(of: isFail) { newValue in
//                            if newValue {
//                                failText = "올바른 이메일 형식이 아닙니다. 다시 입력해주세요."
//                            } else {
//                                failText = " "
//                            }
//                        }
                    
                    Spacer()
                } // HStack
                
                //                .padding(.top, 10) // -> 이게 왜 안에 적용되지?
                //                .frame(height: 76)
                //                .background(Color.blue)
                
                if isVaild {
                    Button("인증 코드 전송") {
                        title = "인증 코드 입력"
                        subTitle = "입력하신 이메일로 인증코드를 전송했어요.\n\(input_email)\n인증코드는 5분간 유효하니, 시간 안에 입력해주세요."
                        isWaiting = true
                        isSend = true
                    }
                    //                .frame(minWidth: 0, maxWidth: .infinity)
                    .buttonStyle(PrimaryButton())
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }else {
                    Button("인증 코드 전송") {
                        // nothing
                        //                        isFail.toggle() // for test
                    }
                    //                .frame(minWidth: 0, maxWidth: .infinity)
                    .buttonStyle(PrimaryDisableButton())
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    //                    .padding(.top, 40)
                } // if isVaild
                
                
                Spacer()
                Button ("인증코드를 받지 못했나요?") {
//                    pwdOptSheet.toggle()
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(ColorPalette.primary.color)
                .padding(.bottom, 17)
//                .sheet(isPresented: , onDismiss: {
//
//                }) {
//
//                }
        } // vstack
            .toast(isShowing: $isSend, text: "이메일로 전송을 완료했어요.") {
                isSend = false
            }
            
//        } // navigationview
    } // var body
    
    func isValidEmailFormat(input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input)
    } // func isValidEmailFormat
    
    func clean() {
        isFail = false
        input_email = ""
        failText = " "
    } // func clean
}

extension VerifyEmailView {
    var _stringfield: some View {
        ZStack (alignment: .trailing) {
            EmailTextField(
                text: $input_email,
                isFirstResponder: true,
                commit: $isEnter)
                .frame(height: 48.0)
            //            .padding([.top, .bottom], 16)
                .padding([.leading, .trailing], 32)
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
                .onChange(of: input_email, perform: { newValue in
                    if newValue.count > 0 {
                        //                    if pwmodel.isFail {
                        //                        pwmodel.isFail = false
                        //                    }
                        //                    pwdColor = ColorPalette.primary.color
                    }
                    
                })
            
            if isWaiting {
                Text(timerText)
                    .padding(.trailing, 32)
                    .foregroundColor(ColorPalette.primary.color)
                    .font(.system(size: 16))
                    .onReceive(timer) { _ in
                        if isWaiting {
                            let dif_time = Int(Date().timeIntervalSince(startTime))
                            timerText = "\(String(format: "%02d", (dif_time / 60))):\(String(format: "%02d", (dif_time % 60)))"
                        }
                    }
            } else if !isWaiting && input_email.count > 0{
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


struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}
