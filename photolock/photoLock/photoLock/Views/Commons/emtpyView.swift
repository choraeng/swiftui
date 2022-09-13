//
//  emtpyView.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/10.
//

import SwiftUI

struct emtpyView: View {
    var body: some View {
        ZStack {
            VStack (spacing: 21) {
                Image("add_arrow")
                    .opacity(0)
                
//                Text(text: "비어있음", size: 24, weight: .bold)
                
                
//                CustomText(text: "업로드를 위해 하단의 업로드 버튼을\n눌러주세요", size: 16)
//                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    
                    Image("add_arrow")
                        .padding(.horizontal, 45)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
