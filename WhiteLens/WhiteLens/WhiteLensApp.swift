//
//  WhiteLensApp.swift
//  WhiteLens
//
//  Created by BAE on 4/5/24.
//

import SwiftUI
import SwiftData

@main
struct WhiteLensApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Book.self,
            ScannedContent.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
