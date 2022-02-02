//
//  contentAdd.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/17.
//

import SwiftUI
import PhotosUI

import CloudKit

struct floatingButton: View {
    // for coredata
    @Environment(\.managedObjectContext) private var viewContext // 무조건 추가만 있으니깐
    
    @EnvironmentObject var sheetStates: ViewStateModel
    
    @State private var isPresentPicker: Bool = false // phpicker를 열기위한 변수
    @State private var isUploadSheeet = false // 추가를 위한 sheet 변수
    
    @State var memoAddSheetShowing: Bool = false
    
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
                    PhotoPicker(isPresentPicker: $isPresentPicker, isUploadSheet: $isUploadSheeet) { type, cImage, cVideo, cMemo in
                        if type == 0{ // image
                            let newImage = ImageEntity(context: viewContext)
                            newImage.name = cImage!.name
                            newImage.size = cImage!.size
                            newImage.height = Int16(cImage!.height)
                            newImage.width = Int16(cImage!.width)
                            newImage.isFavorite = false
                            newImage.data = cImage!.data!//(contents[0].img! as! UIImage).jpegData(compressionQuality: 1.0)
                            newImage.tags = []
                            newImage.memo = ""
                            newImage.createdAt = cImage!.createdAt
                            
                            if viewContext.hasChanges {
                                do {
                                    try viewContext.save()
                                } catch {
                                    let nserror = error as NSError
                                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                }
                            }
                        }else if type == 1{ //video
                            let a = 1
                        }else if type == 2{ // memo
                            let a = 1
                        }
                    }
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

