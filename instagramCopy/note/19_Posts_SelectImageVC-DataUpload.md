# Select Image VC with Post Data update at Firebase

## 구현 화면

- 사용자가 선택한 사진과 택스트를 포스팅하기 위한 기능
- 사용자가 선택한 사진과 입력한 텍스트는 FireBase에 저장

![200601_PostingUIwithFirebase](../image/200601_PostingUIwithFirebase.gif)



## 소스코드

- UploadPost.Swift
  - 사용자가 입력한 내용을 저장히기 위한 데이터 생성 및 Firebase DB저장

```swift
@objc func handlerPostButton() {
        
  guard
  let caption = captionTextView.text,		// 사용자가 입력한 textView 내용
  let postImg = photoImageView.image,		// 사용자가 선택한 이미지
  let currentUid = Auth.auth().currentUser?.uid else { return } // 현재 사용자 Uid

 	// 업로드할 이미지 생성 (jpegData(compressionQuality: _Int_) 1:최상 품질, 0: 최저 품질
  guard let uploadData = postImg.jpegData(compressionQuality: 0.5) else { return }

  // 생성된 시간 데이터 생성
  // 1970년 1월 1일 00:00:00을 기준으로 현재 시간의 차이를 저장
  let creationData = Int(NSDate().timeIntervalSince1970)

  // 이미지 파일의 고유한 스트링값 생성
  let filename = NSUUID().uuidString
        Storage.storage().reference().child("post_images").child(filename).putData(uploadData, metadata: nil) { (metadata, error) in
                                                                                                    	// handle Error
  if let error = error {
  	print("Fialed to upload image to storage with Error", error.localizedDescription)
 		return
	}
            
	// posts image 다운로드 URL 생성
  Storage.storage().reference().child("post_images").child(filename).downloadURL { (url, error) in
  if error != nil { // 에러 처리
  	print("make imageUrl Error")
    return
  } else {
    // URL 정상 생성 여부 확인
    guard let url = url else { return }

    let values =		// FireBase DB에 저장하기 위한 데이터 구조
    ["caption" : caption,
     "creationDate" : creationData,
     "likes" : 0,
     "imageUrl" : url.absoluteString, //이미지 Url -> String 변환
     "ownerUid" : currentUid] as [String:Any] // [String:Any] 타입 케스팅

    
    // let POSTS_REF = DB_REF.child("posts") 
    let postId = POSTS_REF.childByAutoId()

    // 생성된 정보를 Firebase DB에 저장
    postId.updateChildValues(values) { (erro, ref) in
			self.dismiss(animated: true) {
      self.tabBarController?.selectedIndex = 0
      }
   }
  }
}  
                                                                                              

// textViewDidChange 텍스트뷰의 변경사항이 있을떄 실행됨                                                                                                               // textView에 입력된 데이터가 없을 경우 share button비활성화
func textViewDidChange(_ textView: UITextView) {
	guard !textView.text.isEmpty else { // 비었을 경우 nil 반환 -> 비활성화 -> 리턴
    shareButton.isEnabled = false
    shareButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    return
	} 
  // 비어있지 않은경우 -> 활성화
	shareButton.isEnabled = true
	shareButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)                                                                                                              }
```

- SelectImageVC.swift
  - Next Button 눌렀을 때 action 정의

```swift
@objc func handleNext() {
  let uploadPostVc = UploadPostVC() // 인스턴스 생성

  //selectedImageHeader = header, 현재 선택된 이미지(header)를 전달 후 push
  uploadPostVc.selectedImage = header?.photoImageView.image
  navigationController?.pushViewController(uploadPostVc, animated: true)
}
```



## Important Thing

#### FireBase를 통한 멀티 사용자 어플리케이션에서 데이터 목록에 추가 하는 방법

>  멀티 사용자 애플리케이션에서 `childByAutoId` 메소드를 사용하여 목록에 데이터를 추가합니다. `childByAutoId` 메소드는 지정된 Firebase 참조에 새 하위 항목이 추가될 때마다 고유 키를 생성합니다. 목록의 새 요소마다 이러한 자동 생성 키를 사용하면 여러 클라이언트에서 쓰기 충돌 없이 동시에 같은 위치에 하위 항목을 추가할 수 있습니다. `childByAutoId`가 생성하는 고유 키는 타임스탬프에 기초하므로 목록 항목은 시간순으로 자동 정렬됩니다.

#### 시간 데이터 생성 방법

- 시간 데이터 생성 방법

```swift
// 생성된 시간 데이터 생성
// 1970년 1월 1일 00:00:00을 기준으로 현재 시간의 차이를 저장
let creationData = Int(NSDate().timeIntervalSince1970)
```

#### 데이터 생성시 아래 사항을 고려해보자

- 위와 같이 포스팅 에도 소유자, 생성된날짜, 좋아요 수를 나타내기 위한 Int 처럼 다양한 데이터를 저장해야함
- 데이터 구조를 변경하려면 기존에 저장된 데이터들도 변경해야 함
- 어떤 기능을 구현할때 어떤한 정보가 필요한지 미리 생각해보고 요구사항을 정확하게 파악하자



#### 참조

- [Apple - TimIntervalSince1970](https://developer.apple.com/documentation/foundation/nsdate/1407504-timeintervalsince1970)
- [Apple - jpegData(compressionQuality:)](https://developer.apple.com/documentation/uikit/uiimage/1624115-jpegdata)
- [Firebase - iOS에서 데이터 목록 다루기](https://firebase.google.com/docs/database/ios/lists-of-data?hl=ko)
- [Firebase - iOS에서 데이터 읽기 및 쓰기](https://firebase.google.com/docs/database/ios/read-and-write?hl=ko#get_a_firdatabasereference)

