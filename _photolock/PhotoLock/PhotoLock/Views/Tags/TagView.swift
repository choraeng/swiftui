//
//  TagView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/23.
//

import SwiftUI

struct SeperatorBar: View {
    var body: some View {
        Color(red: 0.769, green: 0.769, blue: 0.769)
            .frame(maxWidth: .infinity, maxHeight: 0.5)
            .padding(0)
    }
}

func randomColor() -> Color{
//    var retColor: Color = Color.gray
    
    let colorSet: [Color] = [
        Color.gray, Color.red, Color.blue, Color.yellow, Color.green]
    
//    return colorSet[Int.random(in: 0..<colorSet.count)]
    return colorSet.randomElement() ?? Color.gray
}

struct TagView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var tagName: String = ""
    @Binding var index: Int?

    @EnvironmentObject var CoreDataModel: CoreDataViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .center) {
                Button {
                } label: {
                    CustomText(text: "완료", size: 16, color: Color.textNormal ,weight: .bold)
                }
                .opacity(0)

                Spacer()

                CustomText(text: "태그", size: 18, color: Color.textNormal ,weight: .bold)

                Spacer()


                Button {
                    if tagName.count > 0 {
//                        let result = TagStoage.add(color: Color.red, name: tagName)
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    CustomText(text: "완료", size: 16, color: Color.textNormal ,weight: .bold)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(Color.background)

//            SeperatorBar()
            Divider()
                .padding(0)

            Color.white
                .frame(maxWidth: .infinity, maxHeight: 48)
                .overlay(
                    TextField("태그 이름을 입력하세요.", text: $tagName, onCommit: {
                        CoreDataModel.addTag(color: randomColor(), name: tagName, isIntoItem: true, item: CoreDataModel.currentItems[index!])
                        tagName = ""
                    })
                        .frame(maxWidth: .infinity)//, maxHeight: memoHeight)
                        .padding(.horizontal, 16)
                )

//            SeperatorBar()
            Divider()
                .padding(0)

            CustomText(text: "옵션 선택 또는 생성", size: 13, color: Color.textNormal, weight: .semibold)
                .padding(.top, 30)
                .padding(.leading, 16)
                .padding(.bottom, 10)

            ScrollView{
                LazyVStack(spacing:0){
                    if let tagItems = CoreDataModel.tags {
                        ForEach(0..<tagItems.count, id: \.self){ i in
//                            Button {
//                                CoreDataModel.addTagIntoItem(item: CoreDataModel.currentItems[index!], tag: tagItems[i])
//                                CoreDataModel.deleteTag(tag: tagItems[i])
//                                presentationMode.wrappedValue.dismiss()
//                            } label: {
//                                TagRow(tagName: tagItems[i].name ?? "", r: tagItems[i].r, g: tagItems[i].g, b: tagItems[i].b, a: tagItems[i].a)
                                TagRow(item: CoreDataModel.currentItems[index!], tag: tagItems[i])
//                            }
    //                        Text("Asdf")
    //                            .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .background(Color(red: 0.958, green: 0.958, blue: 0.958))
        .edgesIgnoringSafeArea(.bottom)

    }
}

