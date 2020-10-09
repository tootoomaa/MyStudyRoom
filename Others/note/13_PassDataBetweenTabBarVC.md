# Pass Data Between Tabbar



### 소스코드

- 기능
  - tabBarController 내에 1번 MainVC 에게로 2번 VC에서 데이터 전달을 위한 코드

```swift

guard let window = UIApplication.shared.delegate?.window,
			let tabBarController = window?.rootViewController as? UITabBarController else { return }

guard let naviController = tabBarController.viewControllers?.first as? UINavigationController,
			let mainVC = naviController.visibleViewController as? MainVC else { return } 

// TabBar 안에 ViewController가 아닌 네비게이션 일 경우 한번 더 변환 필요
```

