//
//  SearchPage.swift
//  SearchPage
//
//  Created by Seth on 2021/7/18.
//  Copyright © 2021 lessmore.io. All rights reserved.
//

import SwiftUI

struct SearchPage: StateView {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var store: Store
    var bindingState: Binding<SearchState> {
        return $store.appState.searchState
    }
    @FocusState private var focused: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                LazyVStack (alignment: .leading ,spacing: 0) {
                    ForEach(state.model?.hits ?? []) { item in
                        NavigationLink(destination: FeedDetailPage(id: item.id)) {
                            SearchResultItemView(hint: item)
                        }
                    }
                }
                .navigationBarHidden(true)
                .loadMore(state.updatable) {
                    await run(action: SearchActions.LoadMoreStart())
                }
                .onChange(of: state.sortWay) { sort in
                    dispatch(SearchActions.Start())
                }
                .ignoresSafeArea(.container)
                .background(Color.bgColor)
                
                // 将搜索框视图放在底部
                searchView
            }
            .ignoresSafeArea(.container)
            .navigationBarHidden(true)
        }
    }


    @ViewBuilder
    private var searchView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("sov2ex", text: bindingState.keyword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .focused($focused)
                        .submitLabel(.search)
                        .onSubmit { dispatch(SearchActions.Start()) }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                                self.focused = true
                            }
                        }
                }
                .padding(12) // 增加内边距
                .background(Color.white) // 背景色改为白色
                .cornerRadius(20) // 增加圆角
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2) // 添加阴影
                .padding(.horizontal, 16)
                .padding(.top, 5)
            }
            .padding(.trailing, 10)
//            Divider()
            Rectangle() // 添加一个固定高度的Rectangle
            .frame(height: 30) // 可根据需要调整高度/
            .foregroundColor(.clear) // 设置为透明色
        }
        .visualBlur()
        .background(Color.gray.opacity(0.35))
    }

}

fileprivate struct SearchResultItemView: View {
    let hint: SearchState.Model.Hit
    var data: SearchState.Model.Hit.Source {
        hint.source
    }
    
    var body: some View {
        let padding: CGFloat = 16
        VStack(alignment: .leading) {
            Text(data.title)
                .fontWeight(.semibold)
                .greedyWidth(.leading)
                .lineLimit(2)
            Text(data.content)
                .lineLimit(5)
                .padding(.vertical, 5)
            Text("\(data.creator) 于 \(data.created) 发表, \(data.replyNum) 回复")
                .font(.footnote)
                .foregroundColor(Color.tintColor.opacity(0.8))
        }
        .foregroundColor(Color.bodyText)
        .greedyWidth()
        .padding(padding)
        .background(Color.itemBg)
        .padding(.bottom, 8)
    }
}


struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
            .environmentObject(Store.shared)
    }
}
