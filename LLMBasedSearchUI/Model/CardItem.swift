//
//  CardItem.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import Foundation

struct CardItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let category: String
    let imageName: String?
}
