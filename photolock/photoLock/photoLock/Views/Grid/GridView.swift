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
    
    @Binding var selectedImage: Int?
    var ns: Namespace.ID
    
    let width: CGFloat
    let height: CGFloat
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
    
    
    @GestureState private var selectedImageOffset: CGSize = .zero
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 3) {
                ForEach(0..<items.count, id: \.self) { idx in
                    let item = items[idx]
                    GridCell(uiimage: UIImage(data: item.image!.data!)!, width: width / 3,
                             id: item.id!, ns: ns)
                        .onTapGesture {
                            print("grid cell", item.id!)
                            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
                                selectedImage = idx
                            }
                        }
                }
            }
        }
    }
}
