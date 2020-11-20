# UITableView Paginaion

UITableView에 데이터를 표현해줄 때 서버로부터 한꺼번에 많은 양을 받을 경우 **device 및 server에 부담**이 되기 때문에 사용자가 UITableview를 스크롤 함에 따라서 일정량의 추가 데이터를 호출하도록 하는 구현 방법

### ScrollYOffset

UITableView 는 UIScrollView를 상속하기 때문에 delegate 위임을 통해서 ScrollView Delegate 위임이 가능함. ScrollView Delegate 중 사용자의 Scroll 변화를 감지할 수 있는 `ScrollViewDidScroll` 활용

```swift
**func scrollViewDidScroll(_ scrollView: UIScrollView) {        
  let height: CGFloat = scrollView.frame.size.height            
  let contentYOffset: CGFloat = scrollView.contentOffset.y            
  let scrollViewHeight: CGFloat = scrollView.contentSize.height            
  let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
            
  if distanceFromBottom < height {
    self.addData()            
  }
}**
```

### Cell will Display

willDisplay가 호출되는 시점이 화면에 cell이 보일 때 라는 것을 보장하지 못함, 문제 발생 가능성 있음

```swift
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
  if indexPath.row > dataList.count - 5 {
  // willDisplay 만으로는 cell이 screen에 보여졌다고 보장되지 않음.

  }
}
```

### TableView PrefetchRow

```swift
tableView.prefetchDataSource = self **// 위임자 정의**

func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
	// 데이터를 받아오는 함수 구현
}
```

 해당 함수는 사용자가 스크롤 할 때 Setting될 `Cell`들의 `[indexPath]` 를 앞서서 리턴 해주기 때문에 현재 가지고 있는 데이터의 마지막 인덱스가 indexPath값과 동일할 때 추가 데이터를 호출하는 함수를 실행하면 된다.

- 주의 사항
    - 추가 데이터를 호출 했을 때 비동기로 실행되기 때문에 사용자가 위아래로 스크롤을 빨리 할 경우 데이터 호출 함수가 여러번 실행되는 오류가 발행 하엿음
    - 이를 방지하기 위해서 데이터 API가 실행되었을 떄 `Bool` 값을 통해서 오류를 방지 하였음

        ```swift

        func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        	guard !isDownLoadActive else { return }

        	데이터 호출 함수() // data 추가 완료 후 **isDowndloadActive = false**
        }
        ```

### Refrence

- [https://medium.com/@hanulyun88/swift-uitableview-에서-pagination을-하는-3가지-방법-ba4a024b58e5](https://medium.com/@hanulyun88/swift-uitableview-%EC%97%90%EC%84%9C-pagination%EC%9D%84-%ED%95%98%EB%8A%94-3%EA%B0%80%EC%A7%80-%EB%B0%A9%EB%B2%95-ba4a024b58e5)