//
//  FloatingButton.swift
//  photoLock
//
//  Created by 조영훈 on 2022/08/15.
//

import SwiftUI
import SlideOverCard

struct FloatingButton: View {
    @State var isClick: Bool = false
    
    var body: some View {
        floatingButton
            .slideOverCard(isPresented: $isClick) {
                // dismissed
            } content: {
//                CameraView()
             // 여기서 시트 뷰
                Text("as")
            }
    }
}

extension FloatingButton {
    var floatingButton: some View {
        VStack(spacing: 0){
            Spacer()
            HStack(spacing: 0){
                Spacer()
                
                Button {
                    isClick.toggle()
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(.primary)
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding(16)
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
