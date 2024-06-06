//
//  BookListView.swift
//  WhiteLens
//
//  Created by BAE on 5/2/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @StateObject private var viewModel = BookListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    HStack {
                        NavigationLink(destination: BookDetailView(book: book)) {
                            Text(book.title)
                        }
                        Spacer()
                        Button(action: {
                            if let index = viewModel.books.firstIndex(of: book) {
                                viewModel.deleteBook(at: IndexSet(integer: index))
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.gray)
                                .accessibilityLabel("Delete \(book.title)")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteBook)
            }
            .navigationTitle("책 목록")
            .toolbar {
                Button(action: {
                    viewModel.showAlert = true
                }) {
                    Label("책 추가하기", systemImage: "plus")
                }
                EditButton()
            }
            .alert("책의 제목을 적는 창입니다.", isPresented: $viewModel.showAlert) {
                TextField("이곳에 제목을 입력합니다.",text: $viewModel.newBookTitle)
                    .autocorrectionDisabled()
                Button("완료", action: viewModel.addBook)
                Button("취소", role: .cancel) { }
            }
        }
    }
}

#Preview {
    BookListView()
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

