//
//  stringView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct stringView: View {
    // 상태 관련
    @Binding var isShowingSheet: Bool
    @Binding var currentState: Int // 0 -> start, 1 -> verify
    @Binding var password: String
    @Binding var isPassword: Bool
    
    @State var verifyFail: Bool = false
    
    @State var first_password: String = ""
    @State var input_password: String = ""
    @State var borderColor: Color = Color.gray
    
    // 패스워드 관련
//    var pwMaxLen: Int
    
    func check_password() {
        if first_password == input_password {
            isPassword = true
            password = input_password
        }else {
            borderColor = Color.red
            verifyFail = true
            
            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
            impactMed.impactOccurred()
        }
        
    }
    
    func next_state() {
        first_password = input_password
        input_password = ""
        currentState = 1
        borderColor = Color.gray
    }
    
    var body: some View {
            VStack {
                ZStack(alignment: .trailing) {
                    SecureField("", text: $input_password, onCommit: {
                        if currentState == 0{
                            next_state()
                        }else{
                            check_password()
                        }
                    })
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 1)
                    )
                    .padding()
                    .onChange(of: input_password) { newValue in
                        if verifyFail {
                            verifyFail = false
                        }
                        if input_password.count == 0 {
                            borderColor = Color.gray
                        }else {
                            borderColor = Color.blue
                        }
                    }

                    if input_password != "" {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color(.systemGray3))
                            .padding(.trailing, 35)
                            .onTapGesture {
                                withAnimation {
                                    input_password = ""
                                  }
                            }
                    }
                }
                if verifyFail {
                    Text("Passcode does not match")
                        .foregroundColor(Color.red)
                        .font(.system(size: 16))
                        .padding(.leading, 35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if currentState == 0 {
                        Button("Cancel"){
                            isShowingSheet = false
                        }
                    }else if currentState == 1{
                        Button("Cancel"){
                            currentState = 0
                            input_password = ""
                            borderColor = Color.gray
                            verifyFail = false
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if currentState == 0 {
                        Button("Next"){
                            next_state()
                        }
                        .disabled(input_password.count == 0)
                    }else if currentState == 1{
                        Button("Done"){
                            check_password()
                        }
                        .disabled(input_password.count == 0)
                    }
            }
        }
    }
}
//
//struct stringView_Previews: PreviewProvider {
//    static var previews: some View {
//        stringView()
//    }
//}
