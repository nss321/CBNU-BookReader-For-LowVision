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
    
    var body: some View {
        ZStack {
            viewModel.cameraPreview
                .ignoresSafeArea()
                .onAppear {
                    viewModel.configure()
                }
            
            VStack {
                HStack {
                    // 셔터사운드 온오프
                    Button(action: {viewModel.switchFlash()}) {
                        Image(systemName: viewModel.isFlashOn ?
                              "speaker.fill" : "speaker")
                        .foregroundStyle(viewModel.isFlashOn ? .yellow : .white)
                    }
                    .padding(.horizontal, 30)
                    
                    // 플래시 온오프
                    Button(action: {viewModel.switchSilent()}) {
                        Image(systemName: viewModel.isSilentModeOn ?
                              "bolt.fill" : "bolt")
                        .foregroundStyle(viewModel.isSilentModeOn ? .yellow : .white)
                    }
                    .padding(.horizontal, 30)
                }
                .font(.system(size:25))
                .padding()
                
                Spacer()
                
                HStack{
                    // 찍은 사진 미리보기, 일단 액션 X
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // 사진찍기 버튼
                    Button(action: {viewModel.capturePhoto()}) {
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                    }
                    .frame(width: 75, height: 75)
                    .padding()
                }
            }
            .foregroundStyle(.white)
        }
    }
}


#Preview {
    CameraView()
}
