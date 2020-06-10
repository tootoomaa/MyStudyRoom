# Feed Main UI Build

## 구현 화면

- 사용자들이 업로드한 내용이 보여지는 화면
- 좋아요, 메시지, 저장하기 버튼과 같은 추가 기능을 위한 버튼 추가

![200610_Feed_MainUI](../image/200610_Feed_MainUI.gif)

## 소스코드

- FeedCell.swift
  - Feed화면의 collectionView에 적용된 커스텀 뷰

```swift
// Post 데이터 처리 부분
var post: Post? {
    didSet {
      guard let imageUrl = post?.imageUrl else { print("Error2"); return }
      guard let ownerUid = post?.ownerUid else { print("Error1"); return }
      guard let likes = post?.likes else { return }
      
      Database.fetchUser(with: ownerUid) { (user) in
        self.profileImageView.loadImage(with: user.profileImageUrl)
        self.usernameButton.setTitle(user.username, for: .normal)
        self.configurePostCaption(user: user)
      }
      postImageView.loadImage(with: imageUrl)
      likesLabel.text = "\(likes) likes"
    }
  }
```

- FeedVC.swift
  - Feed화면의 ViewController부분

```swift
// Firebase DB에서 데이터 추출하는 부분
func fetchPosts() {
  POSTS_REF.observe(.childAdded) { (snaphot) in
		let postId = snaphot.key
		guard let dictionary = snaphot.value as? Dictionary<String, AnyObject> else { return }
			let post = Post(postId: postId, dictionary: dictionary)
			self.posts.append(post)		// <- Post데이터를 배열에 저장
      self.posts.sort(by: {(post1, post2) -> Bool in
				return post1.creationDate > post2.creationDate
			})
     self.collectionView?.reloadData()
	}
}

// Collection View에서 post 데이터를 추출하여 view(FeedCell)로 전달 하는 부분
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  // post 나타낼 갯수 등록
  return posts.count
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
	// 커스텀 cell에 post정보 전달
  cell.post = posts[indexPath.row]

  return cell
}
```


