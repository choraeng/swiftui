//
//  GridView.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/10.
//

// https://github.com/apptekstudios/ASCollectionView#usage
import SwiftUI
import ASCollectionView

struct ItemGridView: View {
    var items: [ItemEntity]
    
    @Binding var selectedImage: UUID?
    var ns: Namespace.ID
    
    var body: some View {
        GeometryReader { geo in
            ASCollectionView(data: items, dataID: \.self)
            { item, cell in
                GridCell(uiimage: UIImage(data: item.image!.data!)!,
                         width: geo.size.width / 3)
//                    .matchedGeometryEffect(id: item.id!, in: ns, isSource: true)
                    .onTapGesture {
                        withAnimation {
                            selectedImage = item.id
                        }
                    }
            }
            .layout
            {
                .grid(
                    layoutMode: .fixedNumberOfColumns(3),
                    itemSpacing: 3,
                    lineSpacing: 3,
                    sectionInsets: .init(top: 0, leading: 3, bottom: 0, trailing: 3)
                )
            }
        }
    }
}
