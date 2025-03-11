//
//  CardDetailView.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import SwiftUI

struct CardDetailView: View {
    let title: String
    
    var body: some View {
        Text("\(title)详情页面内容")
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
