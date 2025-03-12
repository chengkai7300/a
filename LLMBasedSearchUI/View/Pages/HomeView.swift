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
            
            // 固定大小的文本输出框
            ScrollViewReader { proxy in
                ScrollView {
                    Text(viewModel.outputText)
                        .font(.system(.body, design: .monospaced)) // 使用等宽字体
                        .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
                        .padding()
                        .id("outputText") // 为 Text 设置唯一标识
                }
                .frame(width: 360, height: 200) // 固定大小
                .background(Color(.systemFill))
                .cornerRadius(10)
                .onChange(of: viewModel.outputText) { _ in
                    // 文本更新时自动滚动到底部
                    withAnimation {
                        proxy.scrollTo("outputText", anchor: .bottom)
                    }
                }
            }
            
            // 底部输入栏
            bottomInputBar
        }
        .onAppear {
            viewModel.simulateOutput() // 启动模拟输出
        }
    }
    
    // 输入栏组件
    private var bottomInputBar: some View {
        HStack(spacing: 12) {
            // 文本输入框
            TextField("输入需求...", text: $viewModel.messageText)
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

#Preview {
    ContentView()
}
