//
//  ContentView.swift
//  testing
//
//  Created by 조영훈 on 2021/11/10.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isTime = false
    var body: some View {
        VStack {
            Text("")
                .padding()
            Button("aa") {
//                timer = timer
                isTime.toggle()
            }
                .padding()
        }
        .onAppear {
            let date = Date()
            print(date)
            let date1 = Calendar.current.date(byAdding: .day, value: 1, to: date)
            print(date1!)
            let date2 = Calendar.current.date(byAdding: .hour, value: 1, to: date)
            print(date2!)
            
            print(date2! < date1!)
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-DD HH:mm:ss"
            
//            let starttime = format.date(from: )
            print(Int(date2!.timeIntervalSince(date1!)))
            
        }
        .onReceive(timer) { _ in
            if isTime{
                print("in")
            }
        }
    }
}
