//
//  TopBar.swift
//  V2er
//
//  Created by Seth on 2021/6/24.
//  Copyright © 2021 lessmore.io. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    var selectedTab : TabId
    
    private var isHomePage: Bool {
        return selectedTab == .feed
    }
    
    private var title: String {
        switch selectedTab {
            case .feed:
                return "V2EX-页面1"
            case .explore:
                return "发现-页面2"
            case .message:
                return "通知-页面3"
            case .me:
                return "我-页面4"
            case .none:
                return .empty
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Image(systemName: "square.grid.2x2")
                        .foregroundColor(.primary)
                        .font(.system(size: 22))
                        .padding(6)
                        .forceClickable()
                        .hide()
//                        .to { TestView() }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                        .font(.system(size: 22))
                        .padding(6)
                        .forceClickable()
                        .to { SearchPage() }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                Text(title)
                    .font(isHomePage ? .title2 : .headline)
                    .foregroundColor(.primary)
                    .fontWeight(isHomePage ? .heavy : .bold)
            }
            .padding(.top, topSafeAreaInset().top)
            .background(VEBlur())
            
            Divider()
                .light()
        }
        .readSize {
            print("size: \($0))")
        }
    }
}

struct TopBar_Previews: PreviewProvider {
//    @State static var selecedTab = TabId.feed
    static var selecedTab = TabId.explore
    
    static var previews: some View {
        VStack {
            TopBar(selectedTab: selecedTab)
            Spacer()
        }
        .ignoresSafeArea(.container)
    }
}
