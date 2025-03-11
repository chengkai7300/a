//
//  CardItemView.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import SwiftUI

struct CardItemView: View {
    let item: CardItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // 图像部分（修复核心）
            Group {
                if let imageName = item.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 80, height: 80)
            .background(Color(.systemFill))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // 文字部分
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 8)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
