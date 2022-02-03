//
//  BottomSheet.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/07.
//

import Foundation
import SwiftUI

//struct BottomSheet<SheetContent: View>: ViewModifier {
struct BottomSheet<Presenting>: View where Presenting: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var keyboardResponder = KeyboardResponder()

    @Binding var isPresented: Bool
    
    var title: String
    let sheetContent: () -> AnyView
    let presinting: () -> Presenting
    
    //    func body(content: Content) -> some View {
    var body: some View {
        //        GeometryReader { geometry in
        ZStack(alignment: .bottom) {
            //                content
            self.presinting()
            
            if isPresented {
                Rectangle()
                //                    .fill(Color.gray)
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        if keyboardResponder.currentKeyboard {
                            hideKeyboard()
                        } else {
                            withAnimation(.easeInOut) {
                                self.isPresented = false
                            }
                        }
                    }
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            CustomText(text: title, size: 24, weight: .bold)
                                .padding(.leading, 4)
                            Spacer()
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    self.isPresented = false
                                }
                            }) {
                                CustomText(text: "취소", size: 18, weight: .bold)
                            }
                            .padding(.trailing)
                        }
                        .padding(.top, 28)
                        .padding(.bottom, 17)
                        .padding(.horizontal, 12)
                        
                        sheetContent()
                            .padding(.bottom, 44)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity)
                    }
                    //                    .clipShape(Capsule())
                    .background(Color(UIColor.systemBackground)) // colorScheme == .dark ? Color(UIColor.systemBackground) : Color.white)
                    .cornerRadius(15)
                    .offset(y: -keyboardResponder.currentHeight*0.9)
                    
                } // vstack 전체 화면
                .zIndex(.infinity)
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.bottom)
            } // if ispreseng
        } // zstack
        
        //        } // geometry
    }
}

extension View {
    //    func customBottomSheet<SheetContent: View>(
    func customBottomSheet(
        isPresented: Binding<Bool>,
        title: String,
        sheetContent: @escaping () -> AnyView
    ) -> some View {
        //        self.modifier(
        //            BottomSheet(isPresented: isPresented,
        //                        title: title,
        //                        sheetContent: sheetContent)
        //        )
        BottomSheet(isPresented: isPresented,
                    title: title,
                    sheetContent: sheetContent,
                    presinting: {self})
    }
}
