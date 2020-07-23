# Date 날짜 관련 

### 이론

1. Calendar
   - 달력 단위 (연도, 월 및 주중)과 절대 시점 사이의 관계를 정의하여 날짜 계산 및 비교 기능을 제공
2. 

- 날짜와 관련한 정보 추출 방법

```swift
// 날짜 데이터 생성 방법
let nowTime = Int(NSDate().timeIntervalSince1970)	// 11593613152 ( 실행 날자에 따라 다)
let oneDayInt: Int = 86400						// 1일에 대한 timeInterval 값
let oneWeekInt: Int = oneDayInt * 7		// 1주일에 대한 interval 값
let now = Date()		// 현재 날자 date 데이터 생성

let cal = Calendar(identifier: .gregorian)	// 캘린터 인스턴스 생성

// 현재 날자 데이터로 부터 각각의 날자 정보 추출
let year = cal.component(.year, from: now)						// 2020 // 년도 정보
let week = cal.dateComponents([.weekday], from: now)	// weekday: 4 isLeapMonth: false 
week.weekday // 4 (일~토) 기준

let month = cal.dateComponents([.month], from: now)		// month: 7 isLeapMonth: false 
month.month		// 7

let weekOfMonth = cal.dateComponents([.weekOfMonth], from: now)	// weekOfMonth: 1 isLeapMonth: false 

// 현재 date 정보를 수정하는 방법
cal.date(bySettingHour: 0, minute: 0, second: 0, of: now)	 // "Jul 1, 2020 at 12:00 AM"

```
- 주간, 월간 데이터 추출 방법

```swift

let amSymbol = cal.amSymbol											//"AM"
let weekArray = cal.shortWeekdaySymbols					//["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
let monthArray = cal.veryShortMonthSymbols			//["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
	
```

- 기타 정보 추출 방법

```swift
let cal = Calendar(identifier: .gregorian)
let now = Date()											

cal.nextWeekend(startingAfter: now)		// 2020-07-03 15:00:00 +0000 to 2020-07-05 15:00:00 +0000
cal.timeZone													// Asia/Seoul (current)
```



### Reference

1. Apple 
   - [Calendar](https://developer.apple.com/documentation/foundation/calendar)
2. Blog
   - [날짜 다루기](https://medium.com/@Alpaca_iOSStudy/날짜-다루기-b008fa101da)
   - [왕초보를 위한 날짜와 시간 사용](https://zeddios.tistory.com/134)
   - [[Xcode / Swift] 날짜와 시간 다루기 | Date() DateComponents()](https://macinjune.com/all-posts/web-developing/swift/xcode-swift-날짜와-시간-다루기-date-datecomponents/)

