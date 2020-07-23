# UIRefreshControl

### 이론

1. 정의 

   - 뷰의 내용을 refreshing하기 위한 기본적인 제어 방법
   - UIRefrechControl은 어떠한 UIScrollView 객체에 적용 가능
   - 사용자가 아래로 스크롤을 내리면 refrech control이 나타나고 progress 에니메이션이 나타난다

2. 소스코드 예시

   - ```swift
     func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       myScrollingView.refreshControl = UIRefreshControl()
       myScrollingView.refreshControl?.addTarget(self, action:
                                                 #selector(handleRefreshControl),
                                                 for: .valueChanged)
     }
     
     @objc func handleRefreshControl() {
       // Update your content…
     
       // Dismiss the refresh control.
       DispatchQueue.main.async {
         self.myScrollingView.refreshControl?.endRefreshing()
       }
     }
     ```



### ScrollView (table, collection) 에서 화면을 밑으로 스트롤 하여 activity Indicator 나오도록 설정

1. 구현 화면

   - 테이블을 아래로 내려 최신 정보를 받아 오도록 설정
   - 상단의 시간은 날씨 정보를 가져온 마지막 시간 표현

   ![UIRefreshControl](../image/09_RefreshControl/UIRefreshControl.gif)

   

2. 구현 코드

   - UIReferchControl 정의 부분

     - ```swift
       lazy var refrechControl: UIRefreshControl = {
         let refControl = UIRefreshControl()
         refControl.tintColor = .white
         refControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
         return refControl
       }()
       ```

   - UIRefrechControl 함수 처리 부분

     - ```swift
       @objc func handleRefreshControl() {
         // Update your content…
         fetchCurrentWeatherData()
         // Dismiss the refresh control.
         DispatchQueue.main.async {
           self.tableView.refreshControl?.endRefreshing()
         }
       }
       ```

   - TableView에 생성된 UIRefrechControl 인스턴스 설정

     - ```swift
       tableView.refreshControl = refrechControl
       ```

   - AttributedString 추가 가능

     - 구현 화면 

       - ![UIRefreshControlWithString](../image/09_RefreshControl/UIRefreshControlWithString.gif)

     - 구현 코드

       - ```swift
           lazy var refrechControl: UIRefreshControl = {
             let refControl = UIRefreshControl()
             refControl.tintColor = .white
             refControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
             
             // ArributedString 설정 후 추가
             let attString = "당겨서 새로고침"
             let refreshControlAttributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.white]
             
             let attributedString = NSAttributedString(string: attString,attributes: refreshControlAttributes)
             
             refControl.attributedTitle = attributedString
             
             return refControl
           }()
         ```

3. 참조 
   -   [Swift 4 UIRefreshControl :: 평생 공부만 해야할듯](https://gigas-blog.tistory.com/44) 
   -  [Apple - UIRefreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
   -   [ios - Changing specific text's color using NSMutableAttributedString in Swift - Stack Overflow](https://stackoverflow.com/questions/25207373/changing-specific-texts-color-using-nsmutableattributedstring-in-swift) 

