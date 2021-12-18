//
//  MainView.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

struct MainView: View {
    @State var selectedImg: [Image] = []
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                MainNavigationView()
                
                MainTabBar()
                    .padding(.vertical, 6)
                
                MainGridView(selectedImage: $selectedImg)
            }
            
            contentAdd(selectedImg: $selectedImg)
        }
    }
}

extension MainView {
    var floatingButton: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(ColorPalette.primary.color)
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 50)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
