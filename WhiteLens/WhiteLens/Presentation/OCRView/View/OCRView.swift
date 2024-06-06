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
