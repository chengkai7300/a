//
//  LLMMessage.swift
//  V2er
//
//  Created by 程开 on 2025/3/12.
//  Copyright © 2025 lessmore.io. All rights reserved.
//

import Foundation

struct LLMMessage: Identifiable {
    let id = UUID()
    let content: String
    let isSystemMessage: Bool
}
