//
//  toast.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import SwiftUI


struct Toast<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    /// The text to show
    let text: String
    
    let complete: () -> Void

    var body: some View {
        if self.isShowing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              withAnimation {
                self.isShowing = false
                complete()
              }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenting()
//                    .blur(radius: self.isShowing ? 1 : 0)

//                VStack {
                HStack(spacing: 10) {
                        Image("select_icon")
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .padding(.leading, 18)
                        
                        Text(self.text)
                            .foregroundColor(Color.white)
                            .font(.system(size: 13))
                        
                        Spacer()
//                    }
//                    .background(Color(red: 0.27, green: 0.287, blue: 1.0, opacity: 0.2))
                }
                .frame(width: geometry.size.width * 0.9,
                       height: 48)
                .background(Color(red: 0.27, green: 0.287, blue: 0.312, opacity: 0.8))
//                .foregroundColor(Color.primary)
                .cornerRadius(4)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
//                .padding([.leading, .trailing], 16)
                .padding(.bottom, 50)

            }

        }
    }

}


extension View {
    func toast(isShowing: Binding<Bool>, text: String, complete: @escaping () -> Void) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text,
        complete: complete)
    }
}
