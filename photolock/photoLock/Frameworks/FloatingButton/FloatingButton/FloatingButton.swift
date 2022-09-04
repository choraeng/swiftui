//
//  FloatingButton.swift
//  FloatingButton
//
//  Created by 조영훈 on 2022/09/04.
//

import SwiftUI

public struct FloatingButton: View {
    @Binding public var isClick: Bool
    
    public init(_ isClick: Binding<Bool>){
        _isClick = isClick
    }
    
    public var body: some View {
        //        GeometryReader { g in
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
        //        }
    }
}

//struct FloatingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingButton()
//    }
//}
