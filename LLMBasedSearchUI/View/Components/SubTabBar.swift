//
//  SubTabBar.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import SwiftUI

struct SubTabBar: View {
    let tabs: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, title in
                    Button(action: {
                        withAnimation {
                            selectedTab = index
                        }
                    }) {
                        Text(title)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedTab == index ? Color.blue.opacity(0.2) : Color.clear)
                            .foregroundColor(selectedTab == index ? .blue : .primary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}
