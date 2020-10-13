

# RxSwift install with Cocoapod



## RxSwift 설치하기 

### cocoapot 설치 및 RxSwift 설치

1. cocoapot 설치하기
   - ```sudo gem install cocoapods```
2. 생성된 프로젝트 폴더로 이동 후 `pod init`실행
   - ![cocoapot_install](../image/1_HelloRxSwift/cocoapot_install.png)
3. 생성된 `podfile 오픈
   - ![podfile](../image/1_HelloRxSwift/podfile.png)
4. podfile 내용 추가
   - `pod 'RxSwift', '~> 4.0'` 
   - ![podfile_contentChange](../image/1_HelloRxSwift/podfile_contentChange.png)
5. pod을 통한 RxSwift 설치 진행
   - `pod install` 입력
6. 설치 완료 확인
   - ![pod_install_finish](../image/1_HelloRxSwift/pod_install_finish.png)
7. `HelloRxSwitft.xcworkspace` 실행



### Reference

-  [CocoaPods.org](https://cocoapods.org/)