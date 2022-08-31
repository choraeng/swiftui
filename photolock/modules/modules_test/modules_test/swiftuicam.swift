//
//  swiftuicam.swift
//  modules_test
//
//  Created by 조영훈 on 2022/08/18.
//

import SwiftUI
import SwiftUICam

class CameraViewModel_ui: ObservableObject {
    @Published var previewURL: URL?
}


struct swiftuicam: View {
    @ObservedObject var events = UserEvents()
    @StateObject var camera = CameraViewModel_ui()
    var body: some View {
        ZStack {
              CameraView(events: events, applicationName: "SwiftUICam")
                .environmentObject(camera)
          CameraInterfaceView(events: events)
        }
    }
}


//
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
