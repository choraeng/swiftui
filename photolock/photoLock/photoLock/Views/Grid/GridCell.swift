//
//  GridCell.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/10.
//

import SwiftUI

struct GridCell: View {
    let item: ItemEntity
    @Binding var isView: Bool
    
    let width: CGFloat
    
    private var image: Image {
        let image = UIImage(data: item.image!.data!)!
                    .resize(width: width)
        return Image(uiImage: image)
    }
    
    var body: some View {
        Button {
            isView.toggle()
        } label: {
            Color.clear
                .aspectRatio(1, contentMode: .fit)
                .background(
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .clipped()
        }
        
    }
}

public extension UIImage {
    
    /// Resizes the image by keeping the aspect ratio
    func resize(width: CGFloat) -> UIImage {
        let scale = width / self.size.width
        let height = self.size.height * scale
//        let width = self.size.width * scale
        let newSize = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}


//struct GridCell_Previews: PreviewProvider {
//    static var previews: some View {
//        GridCell()
//    }
//}
