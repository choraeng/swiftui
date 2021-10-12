//
//  numberView.swift
//  password
//
//  Created by 조영훈 on 2021/10/06.
//

import SwiftUI

struct numberView: View {
    @Environment(\.presentationMode) var presentationMode

    // 상태 관련
    @Binding var currentState: Int // 0 -> start, 1 -> verify
    @State var verifyFail: Bool = false
    
    // view 관련
    @State var titles: [String] = ["Enter a passcode", "Verify your new passcode"]
    @State var password: String = ""
    @State var circleColor: Color = Color.black
    
    // 패스워드 관련
    var pwMaxLen: Int
//    @State var pwInput: String = "" // 사용자 입력 패스워드
    
    
    @AppStorage("AppPW") var AppPW = UserDefaults.standard.string(forKey: "password") ?? "" // 저장된 패스워드
    @Binding var isPassword: Bool
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

                ZStack {
                    pinDots
                    backgroundTF
                }
                if verifyFail {
                    Text("Passcode does not match")
                        .foregroundColor(Color.red)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if currentState == 0 {
                        Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
//                            isCancel = true
                        }
                    }else if currentState == 1{
                        Button("Cancel"){
                            currentState = 0
                            password = ""
                            circleColor = Color.black
                            verifyFail = false
                        }
                    }
                }
            }
        }
    }
    
    var pinDots: some View {
        HStack {
            ForEach(Array(password), id: \.self) {_ in
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16.0, height: 16.0)
                    .foregroundColor(circleColor)
            }
            if password.count <= pwMaxLen {
                ForEach(0..<pwMaxLen-password.count, id: \.self) {_ in
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
        SecureField("", text: $password)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .keyboardType(.numberPad)
            .onChange(of: password) { newValue in
                if verifyFail == true {
                    verifyFail.toggle()
                    circleColor = Color.black
                }
                
                if password.count > pwMaxLen{
//                    clear()
                    password = ""
                }
                
                if password.count == pwMaxLen {
                    if currentState == 0{
                        AppPW = password
                        password = ""
                        currentState = 1
                    }else {
                        if AppPW == password {
                            isPassword = true
                        }else {
                            verifyFail = true
                            circleColor = Color.red
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                        }
                    }
                }
//                checkPw()
            }
    }
}
//
//struct numberView_Previews: PreviewProvider {
//    static var previews: some View {
//        numberView()
//    }
//}
