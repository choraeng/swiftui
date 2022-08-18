//
//  ContentView.swift
//  parkingFee
//
//  Created by 조영훈 on 2022/08/17.
//
import SwiftUI

//blog host
//https://pgnt.tistory.com/

import SwiftUI

// id
// $(':input[name=\"userid\"]')[0].value = 'asdf'
// pw
// $(':input[name=\"pw\"]')[0].value = 'asdf'
// login btn
// $('.btn-login')[0].click()

// num click
// $(':input[value=\(value)]')[0].click()
// 조회
// $('.btn-btm a')[0].click()

// 자기 차 선택
// $('.car-list strong').length
// $('.car-list strong')[idx]
// -> <strong>​----​</strong>
// -> S.components(separatedBy: ["<strong>", "</strong>"])[0]
// $('.car-list li[data-idx=\(value)] a')[0].click()
// 확인
// $('.btn-btm a')[0].click()

// 주차권 남은거 확인
// $('.discount input')[1].value
// ~~-~~
//-> S.components(separatedBy: "-")[0]
// 주차권 선택
// $('.discount input')[idx].click()
// idx 0 -> 무료(3시간), 1 -> 무료 1시간, 2 -> 1시간, 3 -> 4시간
// 적용
// $('.btn-btm a')[0].click()


struct ContentView: View {
    // 관찰 가능한 개체에 구독하고 관찰 가능한 개체가 변경될 때마다 뷰를 무효화하는 속성 래퍼 유형입니다.
    @ObservedObject var viewModel = WebViewModel()
    @State var bar: String = ""
    
    var body: some View {
        VStack {
            //            WebView(url: "https://pgnt.tistory.com/", viewModel: viewModel)
            WebView(url: CONNECTURL, viewModel: viewModel)
            HStack {
                Button(action: {
                    bar = "$(':input[name=\"userid\"]')[0].value = 'asdf'"
                    self.viewModel.foo.send(bar)
                }) {
                    Text("id")
                }
                Button(action: {
                    bar = "$(':input[name=\"pw\"]')[0].value = 'asdf'"
                    self.viewModel.foo.send(bar)
                }) {
                    Text("pw")
                }
                Button(action: {
                    bar = "$('.btn-login')[0].click()"
                    self.viewModel.foo.send(bar)
                }) {
                    Text("login")
                }
            }
        }
        // RunLoop: 입력 소스를 관리하는 개체에 대한 프로그래밍 방식 인터페이스 .main: 메인 스레드의 런 루프를 반환.
        .onReceive(self.viewModel.bar.receive(on: RunLoop.main)){ value in
//            self.bar = value + 1
        }
    }
}


import Foundation
import Combine

// ObservableObject: 개체가 변경되기 전에 내보내는 게시자가 있는 개체 유형입니다.
class WebViewModel: ObservableObject {
    // PassthroughSubject: 다운스트림 구독자에게 요소를 브로드캐스트 하는 주제
    var foo = PassthroughSubject<String, Never>()
    var bar = PassthroughSubject<String, Never>()
}
