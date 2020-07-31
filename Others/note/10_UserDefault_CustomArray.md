# 커스텀 클래스 배열이 UserDafault에 저장이 안되는 증상



- ### 문제 사항

  - 이슈

    - 커스텀 클래스를 Array에 넣고 UserDefault에 저장 불가

  - 관련 코드 부분 

    - UserSelectedCity 라는  class를 만들어 정보를 저장하고 이를 배열 형태로 관리하고자 함

    - ```swift
      // Properties
      var userSelectedCityList: [UserSelectedCity] = []
      
      // Error line
      UserDefaults.standard.set(userSelectedCityList, forKey: "userSelectedCity") // Error!
      ```

  - 에러 로그

    - ```swift
      2020-07-31 08:38:43.841056+0900 PagedTableView[41532:2628664] [User Defaults] Attempt to set a non-property-list object (
          "<PagedTableView.UserSelectedCity: 0x6000037e82a0>",
          "<PagedTableView.UserSelectedCity: 0x6000037e82d0>",
          "<PagedTableView.UserSelectedCity: 0x6000036007b0>"
      ) as an NSUserDefaults/CFPreferences value for key userSelectedCity
      2020-07-31 08:38:43.860115+0900 PagedTableView[41532:2628664] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Attempt to insert non-property list object (
          "<PagedTableView.UserSelectedCity: 0x6000037e82a0>",
          "<PagedTableView.UserSelectedCity: 0x6000037e82d0>",
          "<PagedTableView.UserSelectedCity: 0x6000036007b0>"
      ) for key userSelectedCity'
      ```

- ### **문제 원인**

  -  UserDefault를 통해서 저장되는 값은 일반적인 NSData, NSString, NSNumber 등으로 저장해야 한다

  - 다른 타입의 오브젝트는 NSData로 변환하여 저장하도록 가이드 하고 있다.

  - > A default object must be a property list—that is, an instance of (or for collections, a combination of instances of) NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. **If you want to store any other type of object, you should typically archive it to create an instance of NSData.**

- ### **해결 방법**

  - 커스텀 클래스에 NSObject, NSCoding 프로토콜 체택

    - ```swift
      class UserSelectedCity: NSObject, NSCoding {
        
        var cityName: String
        var lati: Double
        var long: Double
        
        init(cityName: String, lati: Double, long:Double) {
          self.cityName = cityName
          self.lati = lati
          self.long = long
        }
        
        func encode(with coder: NSCoder) {
          coder.encode(cityName, forKey: "cityName")
          coder.encode(lati, forKey: "latitude")
          coder.encode(long, forKey: "longtitude")
        }
        
        required init?(coder: NSCoder) {
          cityName = coder.decodeObject(forKey: "cityName") as! String
          lati = coder.decodeDouble(forKey: "latitude")
          long = coder.decodeDouble(forKey: "longtitude")
        }
      }
      ```

  - 데이터 저장하기

    - ```swift
      do {
        // 저장하고자 하는 데이터`<#CustomData#>`를 NSKeyedArchiver.archivedData을 통해 Data로 변경
        let dataValue = try NSKeyedArchiver.archivedData(
          withRootObject: <#CustomData#>,
          requiringSecureCoding: false
        )
        // 생성된 dataValue를 UserDefault에 저장
        UserDefaults.standard.set(dataValue, forKey: <#keyString#>)
      } catch {
        print(error)
      }
      
      ```

  - 데이터 불러오기

    - ```swift
      // 저장할때 사용 했던 키를 통해 데이터를 불러옴
      guard let data = UserDefaults.standard.data(forKey: <#keyString#>) else { return }
      
      // NSKeyedUnarchiver.unarchiveTopLevelObjectWithData를 통해 데이터를 추출하고 원하는 형태로 타입케스팅 하여 사용
      if let userSelectedCityArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [<#CustomData#>] {
      	// code
      }
      
      ```



- ### 추가로 알아보기

  - NSCoding 프로토콜 체택이유

    - > To support archiving, an object must adopt the `NSCoding` protocol, which consists of two methods. One method encodes the object’s important instance variables into the archive and the other decodes and restores the instance variables from the archive. 
      >
      > **form**  [Object Graphs](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Archiving/Articles/objectgraphs.html#//apple_ref/doc/uid/20001293-CJBDFIBI)

  - 커스텀 클래스 배열(이 예제에서)을 `Data` 형태로 변경하게 되면, 커스텀 클래스 안에 있는 Key&Value값을 구분할 수 없게 된다. 

  - 이러한 이유 때문에  NSCoding 프로토콜을 체택하여 각각 커스텀 클래스의 프로퍼티 별로 인코딩, 디코딩을 해줄수 있는 메소드를 부여해야 하는 의존성을 추가하는것이다. 



### 참조

- [fra3il — NSUserDefaults : attempt to insert non-property list object](https://fra3il.tumblr.com/post/76823865670/nsuserdefaults-attempt-to-insert-non-property) 
- [NSUserDefaults(UserDefaults)로 간단하게 데이터 저장하기 :: lemon_dev](https://lemon-dev.tistory.com/entry/NSUserDefaults) 
- [아카이빙, UserDefaults - 객체 저장방법 · JINiOS](https://jinios.github.io/ios/2018/03/30/archive/) 
- [UserDefaults | Apple Developer Documentation](https://developer.apple.com/documentation/foundation/userdefaults) 
- [NSCoding | Apple Developer Documentation](https://developer.apple.com/documentation/foundation/nscoding) 
- [NSObject | Apple Developer Documentation](https://developer.apple.com/documentation/objectivec/nsobject) 
- [Object Graphs](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Archiving/Articles/objectgraphs.html#//apple_ref/doc/uid/20001293-CJBDFIBI) 
- [NSCoding / NSKeyedArchiver - NSHipster](https://nshipster.com/nscoding/) 

