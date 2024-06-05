//
//  PhotoPickerView.swift
//  WhiteLens
//
//  Created by BAE on 5/28/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @ObservedObject var viewModel: PhotoPickerViewModel
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                OCRView(image: image)
            } else {
                
            }
            
            PhotosPicker(
                selection: $viewModel.selectedItems,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Select Image")
            }
            .onChange(of: viewModel.selectedItems) { newItems in
                viewModel.loadImage(from: newItems.first)
            }
        }
    }
}


struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerViewPreviewWrapper()
    }
}

struct PhotoPickerViewPreviewWrapper: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    init() {
        viewModel.image = UIImage(named: "ocrTestImage")
    }
    
    var body: some View {
        PhotoPickerView(viewModel: viewModel)
    }
}
