

# Build Safe URL in Swift



### URL의 구조

![uri](../image/12_MakeURL/uri.png)



### 안전한 URL 생성 방법

- String 직접 입력 방식

```swift
let query = "swift"
let usl = URL(String: "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=\(query)"
```

- URLComponent 와 URLQueryItem 입력 방식

```swift
var urlComponents = URLComponents()
urlComponents.scheme = "https"
urlComponents.host = "search.naber.com"
urlComponents.queryItems = [
   URLQueryItem(name: "search", value: searchTerm),
   URLQueryItem(name: "format", value: format)
]
```



### Reference

- URL 구조
  -  [URL, URI, URN : 네이버 블로그](https://blog.naver.com/kby88power/220608662914) 
  -  [URL주소란 무엇인가 ? - 코디엔에스 도움말](https://www.codns.com/b/B05-195) 
  -  [SPA & Routing | PoiemaWeb](https://poiemaweb.com/js-spa) 
-  [Building Safe URL in Swift Using URLComponents and URLQueryItem | Xcoding with Alfian](https://www.alfianlosari.com/posts/building-safe-url-in-swift-using-urlcomponents-and-urlqueryitem/) 
-  [Constructing URLs in Swift | Swift by Sundell](https://www.swiftbysundell.com/articles/constructing-urls-in-swift/) 
-  [Building Safe URL in Swift Using URLComponents and URLQueryItem | by Alfian Losari | Swift2Go | Medium](https://medium.com/swift2go/building-safe-url-in-swift-using-urlcomponents-and-urlqueryitem-alfian-losari-510a7b1f3c7e) 

