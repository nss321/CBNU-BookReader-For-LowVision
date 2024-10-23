//
//  BookListViewModel.swift
//  WhiteLens
//
//  Created by BAE on 6/6/24.
//

import SwiftUI
import Combine

class BookListViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var newBookTitle = ""
    @Published var books: [Book] = []
    
    private var dataSource: DataSource
    private var cancellables = Set<AnyCancellable>()
    
    init(dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
        self.books = dataSource.books
        
        dataSource.$books
            .receive(on: DispatchQueue.main)
            .sink { [weak self] books in
                self?.books = books
            }
            .store(in: &cancellables)
    }
    
    func addBook() {
        guard !newBookTitle.isEmpty else { return }
        if books.contains(where: { $0.title == newBookTitle }) {
            // 중복된 책 제목 경고
            showAlert = true
            newBookTitle = ""
            return
        }
        
        let newContent = ScannedContent(pageContent: [])
        let newBook = Book(title: newBookTitle, contents: [newContent])
        
        dataSource.addBook(book: newBook)
        print(newBook.title)
        newBookTitle = ""
    }
    
    func deleteBook(at offsets: IndexSet) {
        offsets.map { books[$0]}.forEach { book in
            dataSource.removeBook(book)
        }
    }
}
