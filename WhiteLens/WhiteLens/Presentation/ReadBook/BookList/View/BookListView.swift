//
//  BookListView.swift
//  WhiteLens
//
//  Created by BAE on 5/2/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Book.title) private var books: [Book]
    
    @State private var showAlert = false
    @State private var newBookTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(
                        destination: BookDetailView(book: book)
                    ) {
                        Text(book.title)
                    }
                }
            }
            .navigationTitle("Books")
            .toolbar {
                Button(action: {
                    showAlert = true
                }) {
                    Label("Add Book", systemImage: "plus")
                }
            }
            .alert("Add New Book", isPresented: $showAlert) {
                TextField("Book Title", text: $newBookTitle)
                Button("Add", action: addBook)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Enter the title of the new book.")
            }
        }
    }
    
    private func addBook() {
        guard !newBookTitle.isEmpty else { return }
        if books.contains(where: { $0.title == newBookTitle }) {
            // 중복된 책 제목 경고
            showAlert = true
            newBookTitle = ""
            return
        }
        
        let newContent = ScannedContent(pageContent: ["Page 1 content", "Page 2 content"])
        let newBook = Book(title: newBookTitle, contents: [newContent])
        
        modelContext.insert(newBook)
        
        do {
            try modelContext.save()
            newBookTitle = ""
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
}

#Preview {
    BookListView()
        .modelContainer(for: [Book.self, ScannedContent.self])
}


struct BookDetailView: View {
    var book: Book
    
    var body: some View {
        TabView {
            ForEach(book.contents.flatMap { $0.pageContent }, id: \.self) { page in
                Text(page)
                    .tabItem {
                        Text("Page \(book.contents.flatMap { $0.pageContent }.firstIndex(of: page)! + 1)")
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .navigationTitle(book.title)
    }
}
