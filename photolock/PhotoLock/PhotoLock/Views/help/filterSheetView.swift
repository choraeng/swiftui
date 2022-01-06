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
                    Text("날짜 오름차순")
                        .font(.system(size: 16))
                        .bold()
                    
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
                    Text("날짜 내림차순")
                        .foregroundColor(Color.black)
                        .font(.system(size: 16))
                        .bold()
                    
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
                    Text("파일 이름별")
                        .foregroundColor(Color.black)
                        .font(.system(size: 16))
                        .bold()
                    
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
                    Text("파일 유형별")
                        .foregroundColor(Color.black)
                        .font(.system(size: 16))
                        .bold()
                    
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
                    Text("파일 크기별")
                        .foregroundColor(Color.black)
                        .font(.system(size: 16))
                        .bold()
                    
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
