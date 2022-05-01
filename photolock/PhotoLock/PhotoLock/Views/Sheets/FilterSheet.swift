//
//  filterSheetView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/02.
//

import SwiftUI

struct filterSheetView: View {
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            Button {
                
            } label: {
                HStack(spacing: 0) {
                    CustomText(text: "날짜 오름차순", size: 16, weight: .bold)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .buttonStyle(SheetButtonStyle())
            
            Button {
                
            } label: {
                HStack(spacing: 16) {
                    CustomText(text: "날짜 내림차순", size: 16, weight: .bold)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .buttonStyle(SheetButtonStyle())
            
            Button {
                
            } label: {
                HStack(spacing: 16) {
                    CustomText(text: "파일 이름별", size: 16, weight: .bold)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .buttonStyle(SheetButtonStyle())
            
            Button {
                
            } label: {
                HStack(spacing: 16) {
                    CustomText(text: "파일 유형별", size: 16, weight: .bold)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .buttonStyle(SheetButtonStyle())
            
            Button {
                
            } label: {
                HStack(spacing: 16) {
                    CustomText(text: "파일 크기별", size: 16, weight: .bold)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 6)
                .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .buttonStyle(SheetButtonStyle())
        } // vstack
    }
}
