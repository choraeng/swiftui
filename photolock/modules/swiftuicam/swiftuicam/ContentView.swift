//
//  ContentView.swift
//  swiftuicam
//
//  Created by 조영훈 on 2022/08/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var events = UserEvents()
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                //                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: reader.size.width * (1.5 / 6.5))
                        .border(.red, width: 2)
                    ZStack {
                        
                        CameraView(events: events, applicationName: "SwiftUICam", _x: reader.size.width, _y: reader.size.width / 3 * 4, __y: reader.size.width * (1.5 / 6.5))
                        //                    .frame(width: reader.size.width, height: reader.size.width / 3 * 4)
//                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(Color.clear)
                                .frame(width: reader.size.width, height: reader.size.width / 3 * 4)
                                .border(.gray, width: 2)
                            
                            Rectangle()
                                .foregroundColor(Color.clear)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .border(.blue, width: 2)
                        }
                    }
                }
                CameraInterfaceView(events: events)
            }
        }
    }
}


struct CameraInterfaceView: View, CameraActions {
    @ObservedObject var events: UserEvents
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tray.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        self.rotateCamera(events: events)
                    }
                Spacer()
                Image(systemName: "tray.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        self.toggleVideoRecording(events: events)
                    }
            }
            Spacer()
            Image(systemName: "tray.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .onTapGesture {
                    self.takePhoto(events: events)
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
