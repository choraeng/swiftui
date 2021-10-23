//
//  stringView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct StringView: View {
    @ObservedObject var pwmodel: PasswordModel

    @State var borderColor: Color = Color.gray
    @Binding var commit: Bool
    
    // 패스워드 관련
    var pwMaxLen: Int

    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                CustomStringTextField(text: $pwmodel.password, isFirstResponder: true, commit: $commit)
                    .frame(height: 16.0)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 1)
                    )
                    .padding()
                    .onChange(of: pwmodel.fail) { newValue in
                        if newValue {
                            borderColor = GlobalValue.false_color
                        }
                    }
                    .onChange(of: pwmodel.password) { newValue in
                        if pwmodel.fail == true {
                            pwmodel.fail.toggle()
                        }
                        
                        if newValue.count == 0 {
                            borderColor = Color.gray
                        } else {
                            borderColor = Color.blue
                        }
                    }
                
                if pwmodel.password != "" {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(Color(.systemGray3))
                        .padding(.trailing, 35)
                        .onTapGesture {
                            withAnimation {
                                pwmodel.password = ""
                            }
                        }
                }
            }
            if pwmodel.fail {
                Text("Passcode does not match")
                    .foregroundColor(GlobalValue.false_color)
                    .font(.system(size: 16))
                    .padding(.leading, 35)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
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
