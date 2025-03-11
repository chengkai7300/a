//
//  HomeView.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // 次级选项栏
            SubTabBar(tabs: viewModel.subTabCategories, selectedTab: $viewModel.selectedSubTab)
                .onChange(of: viewModel.selectedSubTab) { _ in
                    viewModel.refreshFeed()
                }
            
            // 卡片列表
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.cardItems) { item in
                        CardItemView(item: item)
                    }
                }
                .padding()
            }
            
            // 底部输入栏
            bottomInputBar
        }
    }
    
    // 输入栏组件
    private var bottomInputBar: some View {
        HStack(spacing: 12) {
            // 文本输入框
            TextField("输入消息...", text: $viewModel.messageText)
                .textFieldStyle(.roundedBorder)
                .padding(.leading)
            
            // 语音按钮
            Button(action: { viewModel.isRecording.toggle() }) {
                Image(systemName: viewModel.isRecording ? "waveform" : "mic.fill")
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(viewModel.isRecording ? .red : .blue)
                    .clipShape(Circle())
            }
            .padding(.trailing)
        }
        .padding(.vertical, 8)
        .background(.regularMaterial)
    }
}
