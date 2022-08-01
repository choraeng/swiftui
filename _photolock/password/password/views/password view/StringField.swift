//
//  stringView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct StringField: View {
    @ObservedObject var pwmodel: PasswordModel
    @Binding var commit: Bool
    
//    @Binding var input_password: String
    @State var borderColor: Color = Color.gray
    
//    @State var failText: String
    
    // 패스워드 관련
    var _len: Int = 64

    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                CustomStringTextField(text: $pwmodel.input_password, isFirstResponder: true, commit: $commit)
                    .frame(height: 16.0)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 32)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 1)
                                .padding([.leading, .trailing], 16)
                    )
                    // .onChange(of: pwmodel.fail) { newValue in
                    //     if newValue {
                    //         borderColor = GlobalValue.false_color
                    //     }
                    // }
                    // .onChange(of: pwmodel.password) { newValue in
                    //     if pwmodel.fail == true {
                    //         pwmodel.fail.toggle()
                    //     }
                        
                    //     if newValue.count == 0 {
                    //         borderColor = Color.gray
                    //     } else {
                    //         borderColor = Color.blue
                    //     }
                    // }
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
                Text(pwmodel.failtext)
                    .foregroundColor(GlobalValue.false_color)
                    .font(.system(size: 16))
            }
        }
        .onChange(of: pwmodel.isFail) { newValue in
            if newValue {
                borderColor = GlobalValue.false_color
            }else {
                borderColor = Color.blue
            }
        }
        .onChange(of: pwmodel.input_password) { newValue in
            if newValue.count > 0 {
                borderColor = Color.blue
            }else {
                borderColor = Color.gray
            }
        }
    }
}

struct CustomStringTextField: UIViewRepresentable {
    
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
                return super.canPerformAction(action, withSender: sender)
            }
        }
    }
}
