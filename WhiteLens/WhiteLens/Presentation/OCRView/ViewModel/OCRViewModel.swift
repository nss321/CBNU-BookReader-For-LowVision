//
//  OCRViewModel.swift
//  WhiteLens
//
//  Created by BAE on 5/7/24.
//

import Vision
import SwiftUI

class OCRViewModel: ObservableObject {
    @Published var OCRString: String?
    
    func recognizeText(image: UIImage) {
        guard let image = image.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            // 결과값 옵셔널 바인딩
            guard let result = request.results as? [VNRecognizedTextObservation], error == nil else { return }
            // resultd에서 최대 후보군 1개에서 첫번째 후보를 String 타입으로 변환
            let text = result.compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n")
            // 이를 OCR 결과에 반영
            self?.OCRString = text
        }
        
        /// 언어를 인식하는 우선순위 설정
        if #available(iOS 16.0, *) {
            /// 앱의 지원 버전에 따라 가장 최신 revision을 default로 지원해주기 떄문에
            /// 사실 안해도 상관 없다...
            /// VNRecognizeTextRequestRevision3는 iOS 16부터 지원
            request.revision = VNRecognizeTextRequestRevision3
            request.recognitionLanguages = ["ko-KR"]
        } else {
            request.recognitionLanguages = ["en-US"]
        }
        /// 정확도와 속도 중 어느 것을 중점적으로 처리할 것인지
        request.recognitionLevel = .accurate
        /// 언어를 인식하고 수정하는 과정을 거침.
        request.usesLanguageCorrection = true
        
        do {
//            print(try request.supportedRecognitionLanguages())
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    func saveOCRString(to book: Book) {
        guard let ocrString = self.OCRString else { return }
        let content = ScannedContent(pageContent: [ocrString], createdAt: Date())
        book.contents.append(content)
        DataSource.shared.updateBook(book)
    }
}
