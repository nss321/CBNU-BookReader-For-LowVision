//
//  BackgroundModifier.swift
//  WhiteLens
//
//  Created by BAE on 6/5/24.
//

import Foundation
import SwiftUI

struct setSystemBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(uiColor: .systemBackground))
    }
}

struct setSecondarySystemBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(uiColor: .secondarySystemBackground))
    }
}


extension View {
    func systemBackground() -> some View {
        self.modifier(setSystemBackgroundModifier())
    }
    
    func secondarySystemBackground() -> some View {
        self.modifier(setSecondarySystemBackgroundModifier())
    }
}

