//
//  TabBar.swift
//  V2er
//
//  Created by Seth on 2020/5/24.
//  Copyright © 2020 lessmore.io. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject private var store: Store
    var selectedTab : TabId {
        store.appState.globalState.selectedTab
    }
    var unReadMsg: Int = 0
    var tabs: [TabItem]
    @State private var searchText: String = "" // 新增：用于存储搜索框输入的文本
    @State private var showMessageBox = false
    struct MessageItem: Identifiable {
        let id = UUID()
        let content: String
        let timestamp: Date
    }
    
    @State private var messages: [MessageItem] = []
    @State private var displayedMessages: [MessageItem] = []
    @State private var timer: Timer? = nil
    
    init(_ unReadMsg: Int = 0) {
        self.tabs = [TabItem(id: TabId.feed, text: "最新1", icon: "feed_tab"),
                     TabItem(id: TabId.explore, text: "发现2", icon: "explore_tab"),
                     TabItem(id: TabId.message, text: "通知3", icon: "message_tab", badge: unReadMsg),
//                     TabItem(id: TabId.me, text: "我4", icon: "me_tab")]
                     ]
    }


    var body: some View {
        VStack(spacing: 0) {
            
            // 新增：搜索框
            HStack {
                Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                TextField("搜索", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                Button(action: {
                    showMessageBox.toggle()
                }) {
                    Image(systemName: "bell")
                        .foregroundColor(.gray)
                        .padding(7)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            if showMessageBox {
                VStack(spacing: 0) {
                    HStack {
                        Text("消息")
                            .font(.headline)
                            .padding(.leading, 16)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showMessageBox = false
                            }
                        }) {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                                .padding(8)
                        }
                    }
                    .padding(.top, 8)
                    
                    Divider()
                    
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(displayedMessages) { message in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(message.content)
                                        Text(message.timestamp, style: .time)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                                    .animation(.easeInOut(duration: 0.3))
                                    Divider()
                                }
                            }
                            .onAppear {
                                // 模拟从后台获取消息
                                let demoMessages = [
                                    "系统消息1: 欢迎使用V2er",
                                    "系统消息2: 您有3条新通知",
                                    "系统消息3: 今日热点话题更新",
                                    "系统消息4: 好友请求待处理",
                                    "系统消息5: 系统维护通知",
                                    "系统消息6: 新版本可用",
                                    "系统消息7: 您的账户已登录新设备",
                                    "系统消息8: 社区活动即将开始",
                                    "系统消息9: 您收到了5个赞",
                                    "系统消息10: 私信提醒"
                                ]
                                
                                self.messages = demoMessages.enumerated().map { index, content in
                                    MessageItem(content: content, timestamp: Date().addingTimeInterval(-Double(index) * 60))
                                }
                                
                                // 启动定时器逐条显示消息
                                self.timer?.invalidate()
                                self.displayedMessages = []
                                var currentIndex = 0
                                self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                                    if currentIndex < self.messages.count {
                                        withAnimation {
                                            self.displayedMessages.insert(self.messages[currentIndex], at: 0)
                                            proxy.scrollTo(self.messages[currentIndex].id, anchor: .top)
                                        }
                                        currentIndex += 1
                                    } else {
                                        timer.invalidate()
                                    }
                                }
                            }
                            .onDisappear {
                                self.timer?.invalidate()
                                self.timer = nil
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .shadow(radius: 5)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .transition(.move(edge: .top))
                .zIndex(1)
            }
            
            Divider().frame(height: 0.1)
            HStack(spacing: 0) {
                ForEach (self.tabs, id: \.self) { tab in
                    let isSelected: Bool = self.selectedTab == tab.id
                    Button {
                        dispatch(TabbarClickAction(selectedTab: tab.id))
                    } label: {
                        VStack (spacing: 0) {
                            Color(self.selectedTab == tab.id ? "indictor" : "clear")
                                .frame(height: 3)
                                .cornerRadius(0)
                            Image(tab.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 18)
                                .padding(.bottom, 2.5)
                                .padding(.top, 8)
                                .padding(.horizontal, 8)
                                .overlay {
                                    // badge
                                    Group {
                                        if tab.badge > 0 {
                                            badgeView(num: tab.badge)
                                        }
                                    }
                                }
                            Text(tab.text)
                                .font(.caption)
                                .fontWeight(isSelected ? .semibold : .regular)
                                .padding(.bottom, 8)
                        }
                        .foregroundColor(Color.tintColor)
                        .background(self.bg(isSelected: isSelected))
                        .padding(.horizontal, 16)
                        .background(Color.almostClear)

                    }
                }
            }
        }
        .padding(.bottom, topSafeAreaInset().bottom)
        .background(VEBlur())
    }

    private func badgeView(num: Int) -> some View {
        HStack(alignment: .top) {
            Spacer()
            VStack {
                Text(num.string)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding(4)
                    .background {
                        Circle()
                            .fill(Color.red)
                    }
                Spacer()
            }
        }
    }
    
    func bg(isSelected : Bool) -> some View {
        return LinearGradient(
            gradient:Gradient(colors: isSelected ?
                              [Color.hex(0xBFBFBF, alpha: 0.2), Color.hex(0xBFBFBF, alpha: 0.1), Color.hex(0xBFBFBF, alpha: 0.05), Color.hex(0xBFBFBF, alpha: 0.01)] : [])
            , startPoint: .top, endPoint: .bottom)
            .padding(.top, 3)
    }
    
}



enum TabId: String {
    case none
    case feed, explore, message, me
}

class TabItem : Hashable {
    let id : TabId
    var text : String
    var icon : String
    var badge: Int = 0
    
    init(id: TabId, text : String, icon : String, badge: Int = 0) {
        self.id = id
        self.text = text
        self.icon = icon
        self.badge = badge
    }
    
    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.badge == rhs.badge
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

struct TabBar_Previews : PreviewProvider {
    //    @State static var selected = TabId.feed
    
    static var previews: some View {
        VStack {
            Spacer()
            TabBar()
                .background(VEBlur())
        }
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(Store.shared)
    }
    
}

