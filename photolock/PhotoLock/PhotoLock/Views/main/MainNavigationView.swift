//
//  MainNavigationView.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

struct MainNavigationView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            Button {
                
            } label: {
                Image("search_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor(.primary)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            
            Button {
                
            } label: {
                Image("select_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor(.primary)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            
            Button {
                
            } label: {
                Image("setting_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor(.primary)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            
            Button {
                
            } label: {
                Image("create_album_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor(.primary)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 36)
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
