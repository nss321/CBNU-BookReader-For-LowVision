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
    var image: UIImage
    
    var body: some View {
        imageView
            .onAppear {
                viewModel.recognizeText(image: image)
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
        }
        
    }
    
}

#Preview {
    OCRView(image: UIImage(named: "ocrTestImage")!)
}


struct ImagePicker {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
}

extension ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.isPresented = false
        }
    }
}

struct PhotoPickerView: View {
    @Binding var image: UIImage?
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        VStack {
            if let image = image {
                OCRView(image: image)
            } else {
                Text("No Image Selected")
                    .foregroundStyle(.gray)
            }
            
            PhotosPicker(
                selection: $selectedItems,
                matching: .images,
                photoLibrary: .shared()
            ) {
                    Text("Select Image")
            }
            .onChange(of: selectedItems) { newItems in
                guard let firstItem = newItems.first else { return }
                firstItem.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data, let uiImage = UIImage(data: data) {
                            self.image = uiImage
                        }
                    case .success(nil):
                        print("No image was selected.")
                    case .failure(let error):
                        print("Failed to load image: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
