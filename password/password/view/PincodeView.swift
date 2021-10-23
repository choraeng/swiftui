//
//  numberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct PincodeView: View {
    @ObservedObject var pwmodel: PasswordModel

    @State var circleColor: Color = Color.black
    
    // 패스워드 관련
    var pwMaxLen: Int
    
//    @FocusState private var passwordIsFocus: Bool -> ios 15부터 ㅜㅜ

    var body: some View {
        VStack {
            ZStack {
                pinDots
//                backgroundTF
            }
            
            if pwmodel.fail {
                Text("Passcode does not match")
                    .foregroundColor(GlobalValue.false_color)
                    .font(.system(size: 16))
            }
        }
    }
    
    
    var pinDots: some View {
        HStack {
            ForEach(Array(pwmodel.password), id: \.self) {_ in
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16.0, height: 16.0)
                    .foregroundColor(circleColor)
            }
            if pwmodel.password.count <= pwMaxLen {
                ForEach(0..<pwMaxLen-pwmodel.password.count, id: \.self) {_ in
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(circleColor)
                }
            }
        }
        .padding()
    }
    
    var backgroundTF: some View { // text filed
        CustomTextField(text: $pwmodel.password, isFirstResponder: true)
//            .accentColor(.clear)
//            .foregroundColor(.clear)
            .frame(height: 16.0)
//            .keyboardType(.numberPad)
            .onChange(of: pwmodel.fail) { newValue in
                if newValue {
                    circleColor = GlobalValue.false_color
                }else {
                    circleColor = Color.black
//                    let temp: String =
                    pwmodel.password = String(pwmodel.password.last!)
                }
            }
    }
}

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = CustomUITextField(frame: .zero)
        textField.delegate = context.coordinator
        
        textField.isSecureTextEntry = true
        textField.isHidden = true
        textField.keyboardType = .numberPad
        textField.tintColor = .clear
        textField.textColor = .clear
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    class CustomUITextField: UITextField {
        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            switch action {
                    case #selector(UIResponderStandardEditActions.paste(_:)),
                         #selector(UIResponderStandardEditActions.select(_:)),
                         #selector(UIResponderStandardEditActions.selectAll(_:)),
                         #selector(UIResponderStandardEditActions.copy(_:)),
                         #selector(UIResponderStandardEditActions.cut(_:)),
                        #selector(UIResponderStandardEditActions.delete(_:)) :
                        
                            return false
                    default:
                        //return true : this is not correct
                        return super.canPerformAction(action, withSender: sender)
                    }
//
//                if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//                    return false
//                }
//                return super.canPerformAction(action, withSender: sender)
           }
    }
}
