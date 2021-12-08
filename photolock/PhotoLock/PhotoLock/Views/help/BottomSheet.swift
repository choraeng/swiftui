//
//  BottomSheet.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/12/07.
//

import SwiftUI

struct BottomSheet<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var title: String
    let sheetContent: () -> SheetContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                Rectangle()
//                    .fill(Color.gray)
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.isPresented = false
                        }
                    }
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            Text(title)
                                .font(.system(size: 24))
                                .bold()
                                .padding(.leading, 4)
                            Spacer()
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    self.isPresented = false
                                }
                            }) {
                                Text("취소")
                                    .font(.system(size: 18))
                                    .bold()
                            }
                            .padding(.trailing)
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 12)
                        
                        sheetContent()
                            
                    }
//                    .clipShape(Capsule())
                    .background(Color.white)
                    .cornerRadius(15)
                    
                }
                .zIndex(.infinity)
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

extension View {
    func customBottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        title: String,
        sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(BottomSheet(isPresented: isPresented, title: title, sheetContent: sheetContent))
    }
}
