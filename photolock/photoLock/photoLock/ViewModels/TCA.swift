//
//  TCA.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/09.
//
import ComposableArchitecture
import Foundation

struct AppState: Equatable {
    // 아이템 추가 관련
    var isItemAddSheetPresented: Bool = false
    var isMediaSheetPresented: Bool = false
    // 메모 추가도
    
    // 뷰 관련도 해야해, 그리드, 리스트
    
    
}

enum AppAction: Equatable {
    case addItemButtonTapped
    case addMediaButtonTapped
}


struct AppEnvironment {
//    var mainQueue: AnySchedulerOf<DispatchQueue>
//    var uuid: @Sendable () -> UUID
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .addItemButtonTapped:
        state.isItemAddSheetPresented.toggle() 
        return .none
    case .addMediaButtonTapped:
        state.isMediaSheetPresented.toggle()
        return .none
    }
}
