//
//  Alphanumeric.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import SwiftUI

struct AlphanumericKeyboard: View {
    @ObservedObject var pwmodel: PasswordModel
    @Binding var commit: Bool
    
//    @Binding var input_password: String
    @State var borderColor: Color = .textDisabled
    
//    @State var failText: String
    
    // 패스워드 관련
    var _len: Int = 64

    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                CustomStringTextField(text: $pwmodel.input_password, isFirstResponder: true, commit: $commit)
                    .frame(height: 16.0)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 1)
                                .padding(.horizontal, 16)
                    )
                if pwmodel.input_password.count != 0{
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(Color(.systemGray3))
                        .padding(.trailing, 35)
                        .onTapGesture {
                            withAnimation {
                                pwmodel.input_password = ""
                            }
                        }
                }
            }
            if pwmodel.isFail {
                HStack {
                    CustomText(text: pwmodel.failtext, size: 13, color: .error)
                        .padding(.leading, 32)
                    Spacer()
                }
            }
        }
        .onChange(of: pwmodel.isFail) { newValue in
            if newValue {
                borderColor = .error
            }else {
                borderColor = .primaryPressed
            }
        }
        .onChange(of: pwmodel.input_password) { newValue in
            if newValue.count > 0 {
                borderColor = .primaryDisabled
            }else {
                borderColor = .textDisabled
            }
        }
    }
}

struct CustomStringTextField: UIViewRepresentable {
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        
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
    
    func makeUIView(context: UIViewRepresentableContext<CustomStringTextField>) -> UITextField {
        let textField = CustomUITextField(frame: .zero)
        textField.delegate = context.coordinator
        
        textField.isSecureTextEntry = true
        return textField
    }
    
    func makeCoordinator() -> CustomStringTextField.Coordinator {
        return Coordinator(text: $text, commit: $commit)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomStringTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    final class CustomUITextField: UITextField {
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
                return super.canPerformAction(action, withSender: sender)
            }
        }
    }
}
