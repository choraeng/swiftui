//
//  MainNavigationView.swift
//  PhotoLock
//
//  Created by cho on 2021/12/09.
//

import SwiftUI

struct navigationButtonCell: View {
    enum cellType: Int {
        case text
        case img
        case navigation
    }
    
    var type: cellType
    var text: String?
    var imgName: String?
    var content: AnyView?
    
    var complete: () -> Void
    
    
    var body: some View {
        if type == .text{ // 안쓸듯한데 ㅠㅠ
            Button{
                complete()
            } label: {
                
                Text(text!).bold()
            }
        }
        else if type == .img{
            Button {
                complete()
            } label: {
                Image(imgName!)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor(.primary)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
        }
        else if type == .navigation{
            NavigationLink {
                //                complete()
                AnyView(content!)
            } label: {
                Image(imgName!)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .accentColor(.primary)
                    .frame(width: 24.0, height: 24.0)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
        }
        
    }
}

struct MainNavigationView: View {
    @EnvironmentObject var sheetStates: ViewStateModel
    @Binding var isSelectMode: Bool
    @Binding var isSearchMode: Bool
    
    @State var albumAddSheet: Bool = false
    
    var body: some View {
        if isSelectMode {
            selectModeView()
        } else {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                navigationButtonCell(type: .img, imgName: "search_icon") {
                    withAnimation {
                        isSearchMode.toggle()
                    }
                }
                
                navigationButtonCell(type: .img, imgName: "select_icon") {
                    withAnimation {
                        isSelectMode.toggle()
                    }
                }
                
                navigationButtonCell(type: .navigation, imgName: "setting_icon", content: AnyView(SettingView())) {}
                
                navigationButtonCell(type: .img, imgName: "create_album_icon") {
                    withAnimation {
                        sheetStates.albumAddSheetShowing.toggle()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 36)
            
        } // else
    } // body
} // mainnavigationview

extension MainNavigationView {
    func selectModeView() -> some View{
        return HStack(spacing: 0) {
            Button {
                isSelectMode.toggle()
            } label: {
                Text("취소")
                    .bold()
            }
            
            Button {
                
            } label: {
                Image("delete_icon")
                    .renderingMode(.template)
                    .foregroundColor(ColorPalette.primary.color)
                    .padding(.trailing, 24)
            }
            .opacity(0)
            
            Spacer()
            
            Text("asdf")
                .font(.system(size: 18))
                .bold()
            
            Spacer()
            
            Button {
                
            } label: {
                Image("delete_icon")
                    .renderingMode(.template)
                    .foregroundColor(ColorPalette.primary.color)
                    .padding(.trailing, 24)
            }
            
            Button {
                
            } label: {
                Image("move_group_icon")
            }
            
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: 36)
        
    }
}
