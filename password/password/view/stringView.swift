//
//  stringView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct stringView: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    // args
////    @Binding var nowPosition: Int
//
//    // view 관련
//    @State var titles: [String] = ["Enter a passcode", "Verify your new passcode"]
//    @State var isInput: Bool = false
//    @State var borderColor: Color = Color.gray
//    @State var circleColor: Color = Color.black
//    @State var isLoginFail: Bool = false
//    // 패스워드 관련
//    @State var pwMaxLen: Int = 4
//    @State var pwInput: String = "" // 사용자 입력 패스워드
//    @State var pwInputType: Int = 0 // 패스워드 입력 타입, 0 -> 4 1 -> 6 2 -> custom
//    @State var ispwInputTypeDisable = false // 패스워드 입력 설정 액션시트
//
//    @AppStorage("AppPW") var AppPW = UserDefaults.standard.string(forKey: "password") ?? "" // 저장된 패스워드
//
//    // 테스트
//    @State var save = false // 저장 유무
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
    @Environment(\.presentationMode) var presentationMode

    // 상태 관련
    @Binding var currentState: Int // 0 -> start, 1 -> verify
    @State var verifyFail: Bool = false
    
    // view 관련
    @State var titles: [String] = ["Enter a passcode", "Verify your new passcode"]
    @State var password: String = ""
    @State var borderColor: Color = Color.gray
    
//    @State var pwInput: String = "" // 사용자 입력 패스워드
    
    @Binding var isPassword: Bool
    @AppStorage("AppPW") var AppPW = UserDefaults.standard.string(forKey: "password") ?? "" // 저장된 패스워드
    
    // 테스트
    @State var save = false // 저장 유무
    var body: some View {
        NavigationView {
            VStack {
                Text(titles[currentState])
                    .font(.system(size: 21))
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
//                    .padding(.top, 158)
                    .padding(.bottom, 50)

                ZStack(alignment: .trailing) {
                    SecureField("", text: $password,
                                onCommit: {
                        if currentState == 0{
                            AppPW = password
                            password = ""
                            currentState = 1
                            borderColor = Color.gray
                        }else{
                            if AppPW == password {
                                isPassword = true
                            }else {
                                borderColor = Color.red
                                verifyFail = true
                                
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                            }
                        }
                    }
                    )
//                        .textFieldStyle(.roundedBorder)
                    .padding(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 1)
                        )
                    .padding()
    //                    .foregroundColor(Color.white)
                    .onChange(of: password) { newValue in
                        if verifyFail {
    //                        clear()
                            verifyFail = false
                        }
                        if newValue.count == 0 {
                            borderColor = Color.gray
                        }else {
                            borderColor = Color.blue
                        }
    //                    checkPw()
                    }

                    if password != "" {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color(.systemGray3))
                            .padding(.trailing, 35)
                            .onTapGesture {
                                withAnimation {
                                    password = ""
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
                            presentationMode.wrappedValue.dismiss()
                        }
                    }else if currentState == 1{
                        Button("Cancel"){
                            currentState = 0
                            password = ""
                            borderColor = Color.gray
                            verifyFail = false
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if currentState == 0 {
                        Button("Next"){
                            AppPW = password
                            password = ""
                            currentState = 1
                            borderColor = Color.gray
//                            checkPw()
//                            clear()
                        }
                        .disabled(password.count == 0)
                    }else if currentState == 1{
                        Button("Done"){
                            if AppPW == password {
                                isPassword = true
                            }else {
                                borderColor = Color.red
                                verifyFail = true
                                
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                            }
                        }
                        .disabled(password.count == 0)
                    }
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
