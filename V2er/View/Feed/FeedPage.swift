//
//  Home.swift
//  V2er
//
//  Created by Seth on 2020/5/25.
//  Copyright © 2020 lessmore.io. All rights reserved.
//

import SwiftUI

struct FeedPage: BaseHomePageView {
    @EnvironmentObject private var store: Store
    var bindingState: Binding<FeedState> {
        $store.appState.feedState
    }
    var selecedTab: TabId

    var isSelected: Bool {
        let selected = selecedTab == .feed
        if selected && !state.hasLoadedOnce {
            dispatch(FeedActions.FetchData.Start(autoLoad: true))
        }
        return selected
    }

    var body: some View {
        contentView
            .hide(!isSelected)
            .onAppear {
                log("FeedPage.onAppear")
            }
    }

    @ViewBuilder
    private var contentView: some View {
        VStack(spacing: 16) {
            // 导航按钮区域
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    NavigationButton(icon: "explore_tab", title: "热门", destination: EmptyView())
                    NavigationButton(icon: "message_tab", title: "消息", destination: EmptyView())
                    NavigationButton(icon: "me_tab", title: "我的", destination: EmptyView())
                    NavigationButton(icon: "feed_tab", title: "最新", destination: EmptyView())
                }
                HStack(spacing: 16) {
                    NavigationButton(icon: "share_node_v2ex", title: "节点", destination: EmptyView())
                    NavigationButton(icon: "logo", title: "关于", destination: EmptyView())
                    NavigationButton(icon: "captcha", title: "设置", destination: EmptyView())
                    NavigationButton(icon: "avatar", title: "个人", destination: EmptyView())
                }
            }
            .padding(.horizontal)
            
            LazyVStack(spacing: 0) {
            ForEach(state.feedInfo.items) { item in
                NavigationLink(destination: FeedDetailPage(initData: item)) {
                    FeedItemView(data: item)
                }
            }
        }
        .updatable(autoRefresh: state.showProgressView, hasMoreData: state.hasMoreData, scrollTop(tab: .feed)) {
            await run(action: FeedActions.FetchData.Start())
        } loadMore: {
            await run(action: FeedActions.LoadMore.Start(state.willLoadPage))
        }
        .background(Color.bgColor)
    }
}
}

struct NavigationButton<Destination: View>: View {
    let icon: String
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 8) {
                Image(icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                Text(title)
                    .font(.caption)
            }
            .frame(width: 64, height: 64)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct HomePage_Previews: PreviewProvider {
    static var selected = TabId.feed
    
    static var previews: some View {
        FeedPage(selecedTab: selected)
    }
}
