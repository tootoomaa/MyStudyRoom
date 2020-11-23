# GoodWeather App - DataSource Refactoring



### TableViewDataSource 커스터마이징

#### 1차 Refactoring

- TableViewDataSource 커스텀에 필요한 데이터
  1. Cell identifier
  2. Cell의 UI 부분에 넣을 데이터 배열
  3. Cell과 Data를 바인딩
- 변경 코드

```swift
class WeatherDataSource: NSObject, UITableViewDataSource {
  
  let cellIdentifier: String
  private var weatherListVM: WeatherListViewModel
  
  init(_ weatherListVM: WeatherListViewModel) {
    self.cellIdentifier = "WeatherCell" // 1번 Cell identifier
    self.weatherListVM = weatherListVM  // 2번 Cell의 UI에 넣을 데이터 배열
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.weatherListVM.weatherViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherCell else {
      fatalError("Fail to get \(cellIdentifier)")
    }
    
    let weatherVM = self.weatherListVM.modelAt(indexPath.row)
    // 3번 Cell과 Data 바인딩
    weatherVM.name.bind { cell.cityNameLabel.text = $0 }
    weatherVM.currentTemperature.temperature.bind {
      cell.temparatureLabel.text = $0.formatAsDegree
    } 
    return cell
  } 
}
```

- **변경 코드의 문제점**
  1. WeatherListViewModel과 WeatherCell만 사용이 가능하기 때문에 다른 Cell와 ViewModel 에는 적용 불가
  2. Cell의 UI와 VM의 데이터 바인딩 부분을 포함하고 있기 때문에 확장성 없음

#### 2차 Refactoring

- 1차 리펙토링의 문제점을 해결하기 위해서 Generic 타입을  통해 다른 Cell, ViewModel에서도 사용이 가능하도록 설정
- 또한 Cell과 ViewModel 바인딩 부분을 클로져를 통해서 VC에서 직접 설정하도록 변경함으로써 확장성을 높임

```swift
class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
  
  typealias configureCellType = (CellType, ViewModel) -> ()
  
  let cellIdentifier: String
  var items: [ViewModel]
  let configureCell: configureCellType
  
  init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping configureCellType) {
    self.cellIdentifier = cellIdentifier
    self.items = items
    self.configureCell = configureCell // Cell binding 부분을 외부에서 받음
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
      fatalError("Fail to get \(self.cellIdentifier)")
    }
    
    let vm = self.items[indexPath.row]
    self.configureCell(cell, vm) // cell binding 실행
    
    return cell
  }
  
  func updateItems(_ items: [ViewModel]) {
    self.items = items
  }
}
```



### VC에서 Cell 설정 부분

```swift
private var dataSource: TableViewDataSource<WeatherCell, WeatherViewModel>!

override func viewDidLoad() {
    super.viewDidLoad()
    // cell identifier, item (ViewModel) 전달
    self.dataSource = TableViewDataSource(cellIdentifier: "WeatherCell", items: self.weatherListVM.weatherViewModels, configureCell: { (cell, vm) in
			// VM과 Cell contents 바인딩
      vm.name.bind { cell.cityNameLabel.text = $0 }
      vm.currentTemperature.temperature.bind {
        cell.temparatureLabel.text = $0.formatAsDegree
      }
      print("End")
    })
    
    self.tableView.dataSource = self.dataSource
  
  }
```





### Reference

- [Udemy MVVM Cource](https://www.udemy.com/course/mastering-mvvm-for-ios/learn/lecture/14123951#overview)