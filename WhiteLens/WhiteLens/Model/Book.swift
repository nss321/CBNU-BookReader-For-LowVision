//
//  Book.swift
//  WhiteLens
//
//  Created by BAE on 6/5/24.
//

import Foundation
import SwiftData

@Model
class Book {
    @Attribute(.unique) var id: UUID
    var title: String
    var contents: [ScannedContent]

    init(title: String, contents: [ScannedContent] = []) {
        self.id = UUID()
        self.title = title
        self.contents = contents
    }
}

@Model
class ScannedContent {
    @Attribute(.unique) var id: UUID
    var pageContent: [String]

    init(pageContent: [String]) {
        self.id = UUID()
        self.pageContent = pageContent
    }
}