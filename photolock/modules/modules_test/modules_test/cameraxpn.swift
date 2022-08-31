//
//  cameraxpn.swift
//  modules_test
//
//  Created by 조영훈 on 2022/08/18.
//

import SwiftUI

struct cameraxpn: View {
    var body: some View {
        CameraXPN(action: { url, data in
            print(url)
            print(data.count)
        }, font: .subheadline, permissionMessgae: "Permission Denied")
    }
}

struct cameraxpn_Previews: PreviewProvider {
    static var previews: some View {
        cameraxpn()
    }
}
