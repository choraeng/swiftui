//
//  Extension.swift
//  photoLock
//
//  Created by 조영훈 on 2022/09/11.
//

import SwiftUI

// https://stackoverflow.com/questions/56517610/conditionally-use-view-in-swiftui
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

public extension UIImage {
    /// Resizes the image by keeping the aspect ratio
    func resize(width: CGFloat) -> UIImage {
        let scale = width / self.size.width
        let height = self.size.height * scale
        //        let width = self.size.width * scale
        let newSize = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

extension View {
    // content.readSize{ V in }
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}
