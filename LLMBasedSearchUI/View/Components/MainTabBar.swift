//
//  MainTabBar.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import SwiftUI

struct MainTabBar: View {
    let tabs: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, title in
                    Button(action: { selectedTab = index }) {
                        VStack(spacing: 4) {
                            Text(title)
                                .font(.headline)
                                .foregroundColor(selectedTab == index ? .blue : .gray)
                            
                            RoundedRectangle(cornerRadius: 3)
                                .fill(selectedTab == index ? Color.blue : Color.clear)
                                .frame(width: 30, height: 3)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
    }
}
