//
//  CameraView.swift
//  WhiteLens
//
//  Created by BAE on 5/2/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @ObservedObject var viewModel = CameraViewModel()
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            viewModel.cameraPreview
                .frame(width: screenSize.width, height: screenSize.width * 1.3333)
                .padding(.bottom, 72)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.configure()
                }
            
            VStack {
                
                Spacer()
                
                HStack{
                    thumbnailButton
                        .padding()
                    
                    Spacer()
                    
                    shutterButton
                    
                    Spacer()
                    
                    switchButton
                        .padding()
                }
            }
            .foregroundStyle(.white)
        }
        .sheet(isPresented: $viewModel.imagePickerPresented, content: {
            PhotoPickerView(viewModel: PhotoPickerViewModel())
        })
        .sheet(isPresented: $viewModel.OCRViewPresented) {
            if let capturedImage = viewModel.recentImage {
                OCRView(image: capturedImage)
            }
        }
    }
    
    var thumbnailButton: some View {
        Button(action: { viewModel.imagePickerPresented.toggle() }) {
            if let previewImage = viewModel.recentImage {
                Image(uiImage: previewImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: 3)
                    )
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
                    .foregroundColor(.white)
                    .frame(width: 75, height: 75)
            }
        }
    }
    
    var shutterButton: some View {
        Button(action: {viewModel.capturePhoto()}) {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 75, height: 75)
                .padding()
        }
    }
    
    var switchButton: some View {
        Button(action: {viewModel.changeCamera()}) {
            Image(systemName: "arrow.triangle.2.circlepath.camera")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
        }
        .frame(width: 75, height: 75)
    }
}


#Preview {
    CameraView()
}
