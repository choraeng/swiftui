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
    //    @EnvironmentObject var viewModel: CoreDataViewModel
    @Binding var isView: Bool
    var items: [ItemEntity]
    
    var body: some View {
        GeometryReader { geo in
            ASCollectionView(data: items, dataID: \.self)
            { item, _ in
                GridCell(item: item, isView: $isView, width: geo.size.width / 3)
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
