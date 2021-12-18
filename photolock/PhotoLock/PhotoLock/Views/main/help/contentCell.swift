//
//  contentCell.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/17.
//

import SwiftUI

struct contentCell: View {
    var img: Image
//    var clickEvent: () -> Void
    var body: some View {
        Button {
            //                            selectedImg[idx].
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .aspectRatio(1, contentMode: .fit)
                
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .layoutPriority(-1)
            }
            .clipped()
            
        }
    }
}

//struct contentCell_Previews: PreviewProvider {
//    static var previews: some View {
//        contentCell()
//    }
//}
