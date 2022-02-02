//
//  contentCell.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/17.
//

import SwiftUI

struct contentCell: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @Binding var cImage: ContentImage
    var imageItem: FetchedResults<ImageEntity>.Element
    @State var cImage: ContentImage = ContentImage()
//    var img: Image
//    var clickEvent: () -> Void
    var body: some View {
        NavigationLink {
            ImageDetailView(cImage: $cImage)
                .onChange(of: cImage.memo.count) { newValue in
                    imageItem.memo = cImage.memo
                    save()
                }
                .onChange(of: cImage.tags) { newValue in
                    imageItem.tags = cImage.tags
                    save()
                }
                .onChange(of: cImage.isFavorite) { newValue in
                    imageItem.isFavorite = newValue
                    save()
                }
//                .onChange(of: cImage) { newValue in
//                    print(newValue)
//                }
            //                            selectedImg[idx].
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .aspectRatio(1, contentMode: .fit)
                
                Image(uiImage: UIImage(data: imageItem.data!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .layoutPriority(-1)
            }
            .clipped()
        }.onAppear {
            if cImage.name == "" {
                cImage = ContentImage(name: imageItem.name!, size: imageItem.size, height: Int(imageItem.height), width: Int(imageItem.width), isFavorite: imageItem.isFavorite, data: imageItem.data, memo: imageItem.memo!, tags: imageItem.tags!, createdAt: imageItem.createdAt)
            }
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }

    }
}

//struct contentCell_Previews: PreviewProvider {
//    static var previews: some View {
//        contentCell()
//    }
//}
