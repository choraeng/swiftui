//
//  albumCell.swift
//  PhotoLock
//
//  Created by cho on 2021/12/10.
//

import SwiftUI

struct albumCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                Image("album_default")
                    .resizable()
    //                .padding(.horizontal, 7)
    //                .frame(width: 105, height: 105)
                
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fill)
                
                Image("lock")
                    .padding(8)
            }
            Text("앨범 타이틀")
                .padding(.top, 8)
                .font(.system(size: 13))
            Text("1,000")
                .padding(.top, 4)
                .font(.system(size: 13))
                .opacity(0.4)
        }
        .padding(.horizontal, 7)
    }
}

struct albumCell_Previews: PreviewProvider {
    static var previews: some View {
        albumCell()
    }
}
