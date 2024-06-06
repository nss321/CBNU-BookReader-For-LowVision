//
//  PhotoPickerViewModel.swift
//  WhiteLens
//
//  Created by BAE on 5/28/24.
//

import SwiftUI
import PhotosUI

//class PhotoPickerViewModel: ObservableObject {
//    @Published var image: UIImage?
//    @Published var selectedItems: [PhotosPickerItem] = []
//    
//    func loadImage(from item: PhotosPickerItem?) {
//        guard let item = item else { return }
//        item.loadTransferable(type: Data.self) {
//            switch $0 {
//            case .success(let data):
//                if let data = data, let uiImage = UIImage(data:data) {
//                    DispatchQueue.main.async {
//                        self.image = uiImage
//                    }
//                }
//            case .failure(let error):
//                print("Failed to load image: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//
class PhotoPickerViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            loadImage(from: selectedItem)
        }
    }

    func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else {
            image = nil
            return
        }

        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image?):
                    self.image = UIImage(data: image)
                case .success(nil):
                    self.image = nil
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                    self.image = nil
                }
            }
        }
    }
}
