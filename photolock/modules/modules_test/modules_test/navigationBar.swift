//
//  navigationBart.swift
//  modules_test
//
//  Created by 조영훈 on 2022/08/02.
//

import SwiftUI

struct navigationBar: View {
    var body: some View {
        customNavBarView()
    }
}

struct navigationBart_Previews: PreviewProvider {
    static var previews: some View {
        navigationBar()
    }
}



struct customNavBarView: View {
    var body: some View {
        HStack {
            Button{
                
            } label: {
                Text("back")
            }
            Spacer()
            Text("Title")
            Spacer()
        }
    }
}
