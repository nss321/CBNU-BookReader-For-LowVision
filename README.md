
# WhiteLens - 시각 장애인을 위한 독서 유틸리티
- Apple의 독자적인 스크린 리더 VoiceOver를 이용해 책을 촬영하고, 음성으로 책을 읽을 수 있습니다.
  
<br/>

## 주요기능
- 책 스캔 : 카메라를 책을 촬영할 수 있습니다. 촬영 후 책의 내용을 Apple의 Vision 프레임워크를 이용해 텍스트로 변환하고, 이를 VoiceOver를 이용해 탐색할 수 있습니다.
- 책 저장 및 삭제 : SwiftData를 이용하여 스캔한 내용을 하나의 책으로 묶어 로컬 디바이스에 저장하고, 이후에도 열람할 수 있습니다.

## 기술스택
- **Language**: Swift
- **Framework**:  SwiftUI / Vision / AVFoundation / Combine / Foundation
- **Architecture**: MVVM


## 스크린샷

### 1. 메인화면
<img src="https://github.com/user-attachments/assets/e7ff4a67-02ec-4ec6-9b2d-fdbb762a358b" width = 300/>


### 2. 스캔 및 저장
<img src="https://github.com/user-attachments/assets/100c3386-f43d-4aea-bb20-763b550d7397" width = 300/>
<img src="https://github.com/user-attachments/assets/2a15bd41-6ebd-49c5-aaf1-01075f0930c2" width = 300/>
<img src="https://github.com/user-attachments/assets/039ea10c-4935-4b08-a68d-208bd89a7445" width = 300/>

### 3. 책 목록 추가 & 열람
<img src="https://github.com/user-attachments/assets/2b9f0363-1352-4e1c-8ef4-153cba0252c3" width = 300/>
<img src="https://github.com/user-attachments/assets/5b4deb6c-3705-4038-b007-39c5c1183c61" width = 300/>
<img src="https://github.com/user-attachments/assets/358a1bf8-b3a2-49eb-8397-dcf30a2ce5bd" width = 300/>
