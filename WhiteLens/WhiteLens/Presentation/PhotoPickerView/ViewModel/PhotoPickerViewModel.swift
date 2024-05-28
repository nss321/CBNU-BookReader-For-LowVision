//
//  PhotoPickerViewModel.swift
//  WhiteLens
//
//  Created by BAE on 5/28/24.
//

import SwiftUI
import PhotosUI

class PhotoPickerViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var selectedItems: [PhotosPickerItem] = []
    
    func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        item.loadTransferable(type: Data.self) {
            switch $0 {
            case .success(let data):
                if let data = data, let uiImage = UIImage(data:data) {
                    DispatchQueue.main.async {
                        self.image = uiImage
                    }
                }
            case .failure(let error):
                print("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
    
    func removeSelectedImage() {
        self.image = nil
    }
}
