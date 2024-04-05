//
//  Item.swift
//  WhiteLens
//
//  Created by BAE on 4/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
