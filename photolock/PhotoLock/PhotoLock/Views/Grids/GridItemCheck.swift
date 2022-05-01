//
//  GridItemCheck.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/03/01.
//

import SwiftUI

struct GridItemCheck: View {
    var body: some View {
        VStack{
            HStack{
                ZStack() {
                    
                    //            Circle()
                    //                .strokeBorder(Color.white, lineWidth: 1.5)
                    //                .background(Circle().foregroundColor(Color.clear))
                    //                  .frame(width: 22.5, height: 22.5)
                    
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 1.5)
                        .background(Circle().foregroundColor(.primary))
                        .frame(width: 22.5, height: 22.5)
                    
                    
                    Image("check_icon_rounded")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .background(Color.clear)
                        .frame(width: 10, height: 8)
                }
                .padding(8)
                Spacer()
            }
            Spacer()
        }
    }
}

