# SearchVC Feature

## 구현 화면

- 사용자 검색 기능 추가
- 기본 화면은 모든 포스트를 나타내줌
  - 원래 인스타그램에서는 추천 post를 보여주는 화면
- 사용자를 찾기위해서 이름을 입력하기 시작하면 사용자 리스트로 변경

![200621_SearchVC](../image/200621_SearchVC.gif)

## 소스코드

- UISearchBar관련 

```swift
func configureSearchBar() {
    searchBar.sizeToFit()
    searchBar.delegate = self
    navigationItem.titleView = searchBar
    searchBar.barTintColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    searchBar.tintColor = .black
  }

func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
  searchBar.showsCancelButton = true

  // 사용자가 입력을 시작하면 collectionVeiw 숨김 처리
  collectionView.isHidden = true
  collectionViewEnabled = false

  tableView.separatorColor = .lightGray
}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  // handle search text change

let searchText = searchText.lowercased() // 사용자가 입력한 텍스트

  if searchText.isEmpty || searchText == " " { 
    // 사용자가 입력을 취소한 경우
    inSearchMode = false
    tableView.reloadData()
  } else {	
    // 사용자가 입력을 시작한 경우
    inSearchMode = true
    filteredUsers = users.filter({ (user) -> Bool in
				return user.username.lowercased().contains(searchText)
		})
    tableView.reloadData()
  }
}

func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
  searchBar.endEditing(true)

  searchBar.showsCancelButton = false

  inSearchMode = false

  searchBar.text = nil

  collectionViewEnabled = true
  collectionView.isHidden = false

  tableView.separatorColor = .clear

  tableView.reloadData()
}
```

- CollectionView 관련 소스코드

```swift
func configureCollectionView() { // collectionView 설정 부분

  let layout = UICollectionViewFlowLayout()
  layout.scrollDirection = .vertical // 세로로 스크롤 적용

  let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - (tabBarController?.tabBar.frame.height)!-(navigationController?.navigationBar.frame.height)!) 

  collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)

  tableView.addSubview(collectionView) // 이미 잡혀잇는 tableView에 넣기

  collectionView.register(SearchPostCell.self, forCellWithReuseIdentifier: "SearchPostCell")

  collectionView.dataSource = self
  collectionView.delegate = self
  collectionView.alwaysBounceVertical = true
  collectionView.backgroundColor = .white
  tableView.separatorColor = .clear
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
  return 1
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
  return 1
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  let width = (view.frame.width-2) / 3
  return CGSize(width: width, height: width)
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  return posts.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCell", for: indexPath) as! SearchPostCell
	// 포스팅 정보 입력
  cell.post = posts[indexPath.item]

  return cell
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  let feedVC = FeedVC(collectionViewLayout: UICollectionViewFlowLayout())
  feedVC.viewSinglePost = true
  feedVC.post = posts[indexPath.item]

  navigationController?.pushViewController(feedVC, animated: true)
}
```



- **TableView 관련 소스코드**
  1. isSearchMode Bool 값을 통해서 화면에 뿌려주는 데이터 변경
     - ture 
       - 사용자가 검색을 시작하고, 입력한 string이 포함된 사용자 보여줌
     - false 
       - 검색 종료 상태, 모든사용자의 정보를 보여줌

```swift
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  return 60
}

override func numberOfSections(in tableView: UITableView) -> Int {
  return 1
}

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	
  var user: User!	// 임시 저장 변수
  if inSearchMode {
    user = filteredUsers[indexPath.row]
  } else {
    user = users[indexPath.row]
  }

  //create instance of user profileVC
  let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())

  // passes user from searchVc to userProfileVC
  userProfileVC.user = user

  // push view controller
  navigationController?.pushViewController(userProfileVC, animated: true)
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  if inSearchMode {
    return filteredUsers.count	// 사용자가 입력한 스트링이 포함된 사용자 리스트
  } else {
    return users.count	// 전체 사용자 리스트
  }
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell

  var user: User!
  if inSearchMode {
    user = filteredUsers[indexPath.row]	// 필터링된 사용자 데이터 뿌려줌
  } else {
    user = users[indexPath.row] // 전체 사용자 뿌려줌
  }

  cell.user = user

  return cell
}
```


