# UITableView





### UITableView의 Load의 끝을 감지하는 방법

1. 문제 사항

   - tableview를 reloadData를 한 뒤에 실행시켜야할 코드의 적용 시점 문제
   - 특정 row로 이동하야하는 사항

2. 문제 해결 방법

   - 사용 메소드

     1.  스크롤 하는 함수

        - ```swift
          func scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool)
          ```

     2. tableView Cell 을 그릴 때 마지막으로 화면에 그려지는 cell 반환 함수
        
        - ```swift
          var indexPathsForVisibleRows: [IndexPath]? { get }
          ```

   - 소스코드 예시

     - ```swift
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         // 마지막 Cell을 그리고 나서 실행되는 구문
         if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
           if indexPath == lastVisibleIndexPath {
             rankingTable.scrollToRow( // cell 이동
               at: IndexPath.init(row: userRankLocationInArray, section: 0),
               at: .middle,
               animated: false
             )
             setUserRankLocation = true
           }
         }
       }
       ```

3. 참조 
   -  [ios — UITableView의로드 끝을 감지하는 방법](https://www.it-swarm-ko.tech/ko/ios/uitableview%ec%9d%98%eb%a1%9c%eb%93%9c-%eb%81%9d%ec%9d%84-%ea%b0%90%ec%a7%80%ed%95%98%eb%8a%94-%eb%b0%a9%eb%b2%95/970386803/) 
   -  [UITableView scrollToRow, 특정 셀로 스크롤시키기](https://0urtrees.tistory.com/54) 

