//
//  CustomText.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/13.
//

import SwiftUI

struct CustomText: View {
    var text: String
    var size: Float
    var color: Color = .textNormal
    var weight: SwiftUI.Font.Weight = SwiftUI.Font.Weight.medium
//    var font:
    
    
    var body: some View {
        Text(text)
            .font(.custom("Apple SD Gothic Neo", size: CGFloat(size)))
            .foregroundColor(color)
            .fontWeight(weight)
    }
}
