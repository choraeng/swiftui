//
//  MainView.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 0) {
            MainNavigationView()
            
            MainTabBar()
                .padding(.vertical, 6)
            
            MainGridView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
