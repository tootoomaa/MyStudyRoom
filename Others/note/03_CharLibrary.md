# Charts 라이브러리 사용하기

iOS에서 차트를 사용하기위한 라이브러리

### Pod을 통한 Charts 설치

1. 터미널을 통해 해당 프로젝트의 위치로 이동 후 `pod init`

```bash
pod init
```

2. 동일 위치에 `Profile` 파일이 생성되고 해당 파일을 `vi`로 열어 아래와 같이 수정

```bash
# Uncomment the next line to define a global platform for your project
platform :ios, '13.5' # 추가

target 'TodoList' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TodoList
  pod 'Charts' 						# 추가
  pod 'TinyConstraints'		# 추가

end
```

3. `pod install` 을 통한 설치 진행

![200625_Chats_podinstall](../image/03_Charts/200625_Chats_podinstall.png)

4. 새로 생성된 `ChartsDemo.xcworkspace` 파일 오픈 후 `Charts`,`TinyConstratints` 모듈 정상 임포트 확인

![200625_ChartsModuleImport](../image/03_Charts/200625_ChartsModuleImport.png)

5. 에러 유무 확인



### 예제 소스코드 작성

1. ViewController.swift

```swift
import UIKit
import Charts
import TinyConstraints

class ViewController: UIViewController {
  
  lazy var lineChartView: LineChartView = { // liveChartView 객체 생성
    let charView = LineChartView()
    charView.backgroundColor = .systemBlue
    return charView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(lineChartView)
    lineChartView.centerInSuperview()     // TinyConstraints
    lineChartView.width(to: view)         // TinyConstraints
    lineChartView.heightToWidth(of: view) // TinyConstraints
    
  }
}
```

2. 실행 결과

<img src="../image/03_Charts/2006025_Chart_TestPage.png" alt="2006025_Chart_TestPage" style="zoom:50%;" />







## Reference

- Github
  - [Charts](https://github.com/danielgindi/Charts)
- youtube
  - [Chart in Swift - Setting Up a Basic Line Chart Using iOS Charts](https://www.youtube.com/watch?v=mWhwe_tLNE8&list=PL_csAAO9PQ8bjzg-wxEff1Fr0Y5W1hrum&index=5)
- 

