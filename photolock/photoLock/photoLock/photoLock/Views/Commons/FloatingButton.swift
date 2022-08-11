//
//  FloatingButton.swift
//  photoLock
//
//  Created by user on 2022/08/11.
//

import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var sheetStates: ViewStateModel
    
    @State private var isPresentPicker: Bool = false // phpicker를 열기위한 변수
    @State private var isUploadSheeet = false // 추가를 위한 sheet 변수
    
    @State var memoAddSheetShowing: Bool = false
    
    
    @EnvironmentObject var CoreDataModel: CoreDataViewModel
    @EnvironmentObject var currentAlbum: AlbumEntity
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                
                Button {
                    isUploadSheeet.toggle()
                    //                    isPresentPicker.toggle()
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(.primary)
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                }
                .sheet(isPresented: $isPresentPicker) {
                    PhotoPicker(isPresentPicker: $isPresentPicker, isUploadSheet: $isUploadSheeet)
//                    {item in
//                        print(item)
//                        CoreDataModel.addItem(item: item)
//                        CoreDataModel.save()
                        
//                    }
//                    { type, cImage, cVideo, cMemo in
//                        if type == 0{ // image
//                            CoreDataModel.addItem(type: 1,
//                                                  image: CoreDataModel.genImage(name: cImage!.name, size: cImage!.size, createdAt: cImage!.createdAt, width: Int16(cImage!.width), height: Int16(cImage!.height), memo: "", isFavorite: false, data: cImage!.data!),
//                                                  album: currentAlbum)
//                        }else if type == 1{ //video
//
//                        }else if type == 2{ // memo
//
//                        }
//                    }
                }
            }
        }
        .padding(16)
        .customBottomSheet(isPresented: $isUploadSheeet, title: "업로드") {
            AnyView(
                VStack(spacing: 10) {
                    Button {
                        print("ASdfasdf")
                    } label: {
                        HStack(spacing: 16) {
                            Image("camera")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            CustomText(text: "사진 촬영", size: 16, weight: .bold)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        //                    .padding(.horizontal, 6)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .buttonStyle(SheetButtonStyle())
                    
                    
                    
                    Button {
                        isPresentPicker.toggle()
                    } label: {
                        HStack(spacing: 16) {
                            Image("picture")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            CustomText(text: "사진 / 비디오", size: 16, weight: .bold)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        //                    .padding(.horizontal, 6)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .buttonStyle(SheetButtonStyle())
                    
                    Button {
                        withAnimation {
                            sheetStates.memoAddSheetShowing.toggle()
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image("memo")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            CustomText(text: "메모", size: 16, weight: .bold)
                            
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        //                    .padding(.horizontal, 6)
                        .padding(.vertical, 10)
                    }
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .buttonStyle(SheetButtonStyle())
                }
            )
            
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}

