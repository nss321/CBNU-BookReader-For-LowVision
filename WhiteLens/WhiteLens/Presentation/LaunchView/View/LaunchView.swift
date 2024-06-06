//
//  LaunchView.swift
//  WhiteLens
//
//  Created by BAE on 5/2/24.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                
                NavigationLink(
                    destination: CameraView()
                        .systemBackground()
                ) {
                    Text("촬영하기")
                        .frame(width: 140, height: 60)
                        .background(.white)
                        .cornerRadius(10)
                }
                NavigationLink(
                    destination: OCRView(image: UIImage(named: "ocrTestImage")!)
                        .systemBackground()
                ) {
                    Text("스캔하기")
                        .frame(width: 140, height: 60)
                        .background(.white)
                        .cornerRadius(10)
                }
                NavigationLink(
                    destination: BookListView()
                ) {
                    Text("책 목록")
                        .frame(width: 140, height: 60)
                        .background(.white)
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .systemBackground()
        }
    }
}

#Preview {
    LaunchView()
}
