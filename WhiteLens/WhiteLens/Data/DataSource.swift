//
//  DataSource.swift
//  WhiteLens
//
//  Created by BAE on 6/6/24.
//

import SwiftUI
import SwiftData

final class DataSource: ObservableObject {
    private let modelContext: ModelContext
    private let modelContainer: ModelContainer = {
        let schema = Schema([Book.self, ScannedContent.self])
        let modelConfiguration = ModelConfiguration(schema: schema)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    static let shared = DataSource()
    
    @Published var books: [Book] = []
    
    init() {
        modelContext = ModelContext(modelContainer)
        fetchBooks()
    }
    
    func addBook(book: Book){
        modelContext.insert(book)
        do {
            try modelContext.save()
            fetchBooks()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchBooks() {
        do {
            books = try modelContext.fetch(FetchDescriptor<Book>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeBook(_ book: Book) {
        modelContext.delete(book)
        do {
            try modelContext.save()
            fetchBooks() // Fetch books again after removing a book
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
