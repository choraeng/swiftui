//
//  SettingView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/30.
//

import SwiftUI

struct settingRowView: View {
    
    var body: some View {
        Text("")
    }
}

struct SettingView: View {
    @State var isBlackboxEnable = false
    @State var isFaceIDEnable = false // 페이스 아이디 말고 생체인식같은걸로 쓰는거는?
    @State var isSystemscene = false // 기본 화이트냐, 시스템이냐
    @State var isDeleteAfterUpload = false // 업로드 후 삭제
    
    
    var body: some View {
//        ScrollView {
//            VStack(spacing: 0){
        Form {
                HStack {
                    Spacer()
                    
                    Button {
                    } label: {
                        Image("close_icon")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                } // hstack, navigation
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                
                Text("ASDf")
                
                
                    Section(header: Text("일반")) {
                        NavigationLink {
                            
                        } label: {
                            Text("이메일 인증")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("비밀번호 설정")
                        }
                    }
                    
                    Divider()
                    
                    Section(header: Text("구독")) {
                        NavigationLink {
                            
                        } label: {
                            Text("앱 아이콘 설정")
                        }
                        
                        Toggle(isOn: $isBlackboxEnable) {
                            Text("블랙 박스")
                        }
                        
                        Toggle(isOn: $isFaceIDEnable) {
                            Text("페이스아이디")
                        }
                        
                        Toggle(isOn: $isSystemscene) {
                            Text("다크모드/시스템")
                        }
                        
                        Toggle(isOn: $isDeleteAfterUpload) {
                            Text("업로드 후 삭제")
                        }
                    }
                    
                    Divider()
                    
                    Section(header: Text("지원")) {
                        NavigationLink {
                            
                        } label: {
                            Text("앱 공유하기")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("피드백")
                        }
                        
                        NavigationLink {
                            
                        } label: {
                            Text("버전정보")
                        }
                    }
                }
                
                
//            } // vstack
        
//            .padding(.horizontal, 16)
            .navigationBarHidden(true)
//        }
    } // body
} // view

