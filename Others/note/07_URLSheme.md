# URL Scheme

- 현재 실행중인 앱 이외의 다른 앱 실행을 요청하거나, 간단한 데이터를 전달하기 위해 사용되는 방법
- 미리 정해진 형식의 URL을 통해 다른 앱과 통신할 수 있는 수단을 제공
- Info.plist 에 `LSApplicationQueriesSchemes`키에 앱의 주소를 사전등록하여 화이트 리스트 방식으로 동작



### Instagram  Scheme Prameter 

| URL              | 열기                                                         |
| ---------------- | ------------------------------------------------------------ |
| `app`            | Instagram 앱을 실행합니다.                                   |
| `camera`         | 카메라가 아닌 기기에서 카메라 뷰 또는 사진 라이브러리를 켜고 Instagram 앱을 실행합니다. |
| `media?id=`      | Instagram 앱을 실행하고 제공된 ID 값(`int`)과 일치하는 게시물을 읽어들입니다. |
| `user?username=` | Instagram 앱을 실행하고 제공된 사용자 이름 값(`string`)과 일치하는 Instagram 사용자를 읽어들입니다. |
| `location?id=`   | Instagram 앱을 실행하고 제공된 ID 값(`int`)과 일치하는 위치 피드를 읽어들입니다. |
| `tag?name=`      | Instagram 앱을 실행하고 제공된 이름 값(`string`)과 일치하는 해시태그에 맞는 페이지를 읽어들입니다. |



### Naver Map Scheme 

1. 기본 구조

   - 네이버 지도 앱 URL Scheme은 `nmap://`으로 시작하며, 기본 구조는 다음과 같습니다.

   - ```swift
     nmap://actionPath?parameter=value&appname={YOUR_APP_NAME}
     ```

2. 파라미터

   - | 파라미터 | 타입   | 필수 여부 | 설명                                                         |
     | -------- | ------ | --------- | ------------------------------------------------------------ |
     | lat      | double | N         | 지도의 중심 위도. -입력값: `31.43`~`44.35` -기본값: 앱의 기존 상태 유지 |
     | lng      | double | N         | 지도의 중심 경도. -입력값: `122.37`~`132.00` -기본값: 앱의 기존 상태 유지 |
     | zoom     | double | N         | 지도의 줌 레벨. -입력값: `4`~`20` -기본값: 앱의 기존 상태 유지 |



### 관련 특이사항

####  String -> URL 변경시 optional 값으로 분류되면서 nil 값이 나오는 경우

- 문제 증상 : URL주소에 스페이스가 들어가거나 한글이 들어갈 경우 url이 nil이 됨

- 문제 해결 방법 : 인코딩을 통해서 한글과 스페이스를 변경해줌

- ```swift
  if let encoded  = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
   let myURL = URL(string: encoded){
    print(myURL)
  }
  ```

  - 출처 : https://zeddios.tistory.com/281 [ZeddiOS]



### Reference

- [Naver URL Scheme](https://docs.ncloud.com/ko/naveropenapi_v3/maps/url-scheme/url-scheme.html#route_params)
- [FaceBook URL Scheme(Instagram)](https://developers.facebook.com/docs/instagram/sharing-to-feed)
- [apple URL Scheme](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html)
- [iOS ) String -> URL시 nil이 반환될 때](https://zeddios.tistory.com/281) 출처:  [ZeddiOS]]