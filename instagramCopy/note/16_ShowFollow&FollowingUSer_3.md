# Follow, Following User Check Page Build 3

## 구현 화면

- 팔로우,팔로잉 상태에 따른 버튼 텍스트 변경
- 해당 화면에서 팔로우 팔로잉 가능하도록 수정

![200531_FollowFollowingPage2](../image/200531_FollowFollowingPage2.gif)







## 소스코드

- Protocol.wift
  - FollowCell 에서 FollowVC로 Delegate처리 

```swift
protocol FollowCellDelegate {   
    func handleFollowTapped(for cell: FollowCell)
}
```

- FollowCell.swift
  - 팔로우 팔로잉 버튼 눌렀을때 처리되는 부분

```swift
//MARK: - Properties
var delegate: FollowCellDelegate?
var user: User? {
  didSet {
    guard let profileImageUrl = user?.profileImageUrl else { return }
    guard let username = user?.username else { return }
    guard let fullname = user?.name else { return }

    profileImageView.loadImage(with: profileImageUrl)

    self.textLabel?.text = username
    self.detailTextLabel?.text = fullname

    //자기 자신을 팔로우, 팔로잉을 못하도록 버튼 숨김
    if user?.uid == Auth.auth().currentUser?.uid {
      followButton.isHidden = true
    }

    user?.checkIfUserIsFollowed(completion: { (followed) in
			 if followed {
				 // 해당 사용자가 팔로우한 사람이면 버튼 아래와 같이 설정
         self.followButton.setTitle("Following", for: .normal)
         self.followButton.setTitleColor(.black, for: .normal)
         self.followButton.layer.borderColor = UIColor.lightGray.cgColor
         self.followButton.layer.borderWidth = 0.5
         self.followButton.backgroundColor = .white
       } else {
				 // 해당 사용자가 팔로우한 사람이 아니면 버튼 아래와 같이 설정
         self.followButton.setTitle("Followed", for: .normal)
         self.followButton.setTitleColor(.white, for: .normal)
         self.followButton.layer.borderWidth = 0
         self.followButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
     			}                                  
			})
  }
}

//== Button Action 부분 
@objc func handleFollowTapped() { // FollowVC에 정의된 함수 실행
  delegate?.handleFollowTapped(for: self)
}
```

- FollowVC.swift ( FollowCellDelegate 체택 )

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FollowCell
        
        cell.delegate = self	// delega 설정
        cell.user = users[indexPath.row]
        
        return cell
}

// 사용자 선택시 해당 사용자의 프로필 정보 보여줌
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  let user = users[indexPath.row]

  let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
	// 현제 선택된 Cell의 사용자 정보를 전달
  userProfileVC.currentUser = user
  // userProfileVC 띄우기
  navigationController?.pushViewController(userProfileVC, animated: true)
}

func handleFollowTapped(for cell: FollowCell) {
	// 팔로우일댸 누르면 언팔로우
  guard let user = cell.user else { return }
  if user.isFollowed {
    user.unfollow()
    // configure followed button
    cell.followButton.setTitle("Followed", for: .normal)
    cell.followButton.setTitleColor(.white, for: .normal)
    cell.followButton.layer.borderWidth = 0
    cell.followButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
  } else { 	// 언팔로우일댸 누르면 팔로우
    user.follow()
    // configure following button
    cell.followButton.setTitle("Following", for: .normal)
    cell.followButton.setTitleColor(.black, for: .normal)
    cell.followButton.layer.borderColor = UIColor.lightGray.cgColor
    cell.followButton.layer.borderWidth = 0.5
    cell.followButton.backgroundColor = .white
  }
}
```



## Important Thing

- Firebase observe 함수관련
  1. observe : DB에 변화가 있을 경우 즉시 갱신
  2. observeSingleEvent : DB에서 한번만 가져옴



















