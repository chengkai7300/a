//
//  ContentView.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var selectedMainTab = 0
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                TabView(selection: $selectedMainTab) {
                    // 首页
                    HomeView(viewModel: viewModel)
                        .tabItem {
                            Label("首页", systemImage: "house")
                        }
                        .tag(0)
                    
                    // 发现页
                    DiscoverView()
                        .tabItem {
                            Label("发现", systemImage: "magnifyingglass")
                        }
                        .tag(1)
                    
                    // 个人页
                    ProfileView()
                        .tabItem {
                            Label("我的", systemImage: "person")
                        }
                        .tag(2)
                }
                .accentColor(.blue)
                .onAppear {
                    viewModel.refreshFeed()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    ContentView()
}
