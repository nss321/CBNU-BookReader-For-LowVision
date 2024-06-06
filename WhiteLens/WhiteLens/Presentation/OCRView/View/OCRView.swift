//
//  OCRView.swift
//  WhiteLens
//
//  Created by BAE on 5/7/24.
//

import SwiftUI
import Vision
import PhotosUI

struct OCRView: View {
    
    @ObservedObject private var viewModel = OCRViewModel()
    @State private var showSheet = false
    @State private var selectedBook: Book?
    
    var image: UIImage
    
    var body: some View {
        imageView
            .onAppear {
                viewModel.recognizeText(image: image)
            }
            .onChange(of: image) {
                viewModel.recognizeText(image: image)
            }
            .sheet(isPresented: $showSheet) {
                BookSelectionView { book in
                    self.selectedBook = book
                    viewModel.saveOCRString(to: book)
                    
                }
            }
    }
    
    var imageView: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            ScrollView {
                Text(viewModel.OCRString ?? "")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            Button {
                showSheet = true
            } label: {
                Text("저장하기")
            }

        }
    }
}

#Preview {
    OCRView(image: UIImage(named: "ocrTestImage")!)
}

struct BookSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var dataSource = DataSource.shared
    @State private var isPresented = false
    var onSelect: (Book) -> Void
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            List(dataSource.books) { book in
                Button {
                    onSelect(book)
                    dismiss()
                } label: {
                    Text(book.title)
                }
            }
            .navigationTitle("책 선택")
            .toolbar {
                Button(action: {
                    isPresented = true
                }) {
                    Label("책 추가하기", systemImage: "plus")
                }
            }
            .alert("책의 제목을 적는 창입니다.", isPresented: $isPresented) {
                TextField("이곳에 제목을 입력합니다.",text: $text)
                    .autocorrectionDisabled()
                Button("완료", action: {print(text)})
                Button("취소", role: .cancel) { }
            }
        }
        .onAppear{
            dataSource.fetchBooks()
        }
    }
}
