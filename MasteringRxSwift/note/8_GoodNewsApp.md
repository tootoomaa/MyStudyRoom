# GoodNews App

## 구현 화면

- New API를 통해서 뉴스 데이터를 받아와 tableView에 뿌려주는 화면 구현
- RxSWift를 이용한 비동기 처리 

![GoodNewsApp](../image/GoodNewsApp.gif)



## 소스코드 내용

- 비동기 데이터 처리 부분

  - ```swift
     private func populateNews() { 
        URLRequest.load(resource: ArticlesList.all)
          .subscribe(onNext: { [weak self] result in
            if let result = result {
              self?.articles = result.articles
              DispatchQueue.main.async {
                self?.tableView.reloadData()
              }
            }
          }).disposed(by: disposeBag)
      }
    ```

- URLRequest Extension

  - ```swift
    struct Resource<T: Decodable> {
      let url: URL
    }
    
    extension URLRequest {
      // Generic Type을 사용해 다른 타입에도 사용 가능하도록 확장성 부여
      static func load<T>(resource: Resource<T>) -> Observable<T?> {
        
        return Observable.from([resource.url])
          .flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request) // 데이터 다운로드
          }.map { data -> T? in
            return try? JSONDecoder().decode(T.self, from: data) // 데이터 디코딩
          }.asObservable() // 옵져버블 리턴
      }
    }
    ```

- Artivle Model

  - ```swift
    struct ArticlesList: Decodable {
      let articles: [Article]
    }
    
    extension ArticlesList {
      // ArticlesList.all 호출을 통해서 API url이 포함되어 있는 Resouce를 받음
      static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=`mykey`")!
        return Resource(url: url)
      }()
    }
    
    struct Article: Decodable {
      let title: String
      let description: String?
    }
    ```

### Reference

-  [Top headlines - Documentation - News API](https://newsapi.org/docs/endpoints/top-headlines) 