//
//  LaunchView.swift
//  WhiteLens
//
//  Created by BAE on 5/2/24.
//

import SwiftUI
import UIKit

enum MenuSelect: Int {
    case none = 0
    case scanBook, readBook
}

struct LaunchView: View {
    @State private var menuNum: MenuSelect? = .none

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Button {
                    print("1")
                    menuNum = .scanBook
                } label: {
                    Text("책 스캔하기")
                        .frame(width: 140, height: 60)
                        .background(.white)
                        .cornerRadius(10)
                }
                
                Button {
                    print("2")
                    menuNum = .readBook
                } label: {
                    Text("책 읽기")
                        .frame(width: 140, height: 60)
                        .background(.white)
                        .cornerRadius(10)

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationDestination(item: $menuNum) { Hashable in
                switch Hashable {
                case .scanBook:
                    CameraView()
                case .readBook:
                    BookListView()
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
