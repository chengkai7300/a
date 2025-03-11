//
//  CardViewModel.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    // 数据状态
    @Published var cardItems: [CardItem] = []
    @Published var selectedSubTab = 0
    @Published var isRecording = false
    @Published var messageText = ""
    
    // 常量配置
    let mainTabs = ["首页", "发现", "我的"]
    let subTabCategories = ["推荐", "热门", "最新", "专栏"]
    
    // 加载数据
    func refreshFeed() {
        let category = subTabCategories[selectedSubTab]
        cardItems = [
            CardItem(title: "\(category)内容1",
                    description: "这是\(category)的第一个示例内容",
                    category: category,
                    imageName: nil),
            CardItem(title: "\(category)内容2",
                    description: "这是\(category)的第二个示例内容",
                    category: category,
                    imageName: "photo2")
        ]
    }
    
    // 发送消息
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        // 这里添加实际的消息处理逻辑
        messageText = ""
    }
}
