//
//  font test.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/09.
//

import SwiftUI

struct font_test: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.custom("Apple SD Gothic Neo", size: 17))
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.system(size: 17))
            CustomText(text: "Hello, World!", size: 17)
        }
    }
}

struct font_test_Previews: PreviewProvider {
    static var previews: some View {
        font_test()
    }
}
