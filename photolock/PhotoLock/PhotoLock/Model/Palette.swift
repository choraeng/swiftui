//
//  ColorPalette.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/06.
//

import Foundation
import SwiftUI

enum ColorPalette{
    case primary
    case primary_pressed
    case primary_disabled
    
    case text
    case text_disaled
    case text_emphasis
    
//    case secondary
    
    case status_error
    
    var color: Color {
        switch self {
        case .primary: return Color(red: 0.153, green: 0.337, blue: 0.929)
        case .primary_pressed: return Color(red: 0.082, green: 0.208, blue: 0.612)
        case .primary_disabled: return Color(red: 0.153, green: 0.337, blue: 0.929, opacity: 0.4)
        case .text: return Color(red: 0.078, green: 0.078, blue: 0.086)
        case .text_disaled: return Color(red: 0.62, green: 0.624, blue: 0.627)
        case .text_emphasis: return Color(red: 0.246, green: 0.246, blue: 0.262)
        case .status_error: return Color(red: 0.946, green: 0.296, blue: 0.296)
        }
    }
}
//
struct PrimaryButton: ButtonStyle {
    var condition: Bool
    func makeBody(configuration: Configuration) -> some View {
        if condition {
            configuration.label
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 48)
    //                    .background(ColorPalette.primary.color)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(configuration.isPressed ? ColorPalette.primary_pressed.color : ColorPalette.primary.color))
                        .foregroundColor(.white)
                        
    //                    .frame(width: .infinity)
    //                    .scaleEffect(configuration.isPressed? 1.2 : 1)
                        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }else {
            configuration.label
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 48)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(ColorPalette.primary_disabled.color))
                        .foregroundColor(.white)
                        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
                    
    }
}

struct PrimaryDisableButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(ColorPalette.primary_disabled.color))
                    .foregroundColor(.white)
                    .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct SheetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 4)
                            .fill(configuration.isPressed ? Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 0.15) : Color.clear))
    }
}
