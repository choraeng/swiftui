//
//  ViewStateModel.swift
//  PhotoLock
//
//  Created by ์กฐ์ํ on 2022/01/04.
//

import Foundation
import Combine

final class ViewStateModel: ObservableObject {
    @Published var albumAddSheetShowing = false
    @Published var memoAddSheetShowing = false
    
    init() {
        albumAddSheetShowing = false
    }
}
