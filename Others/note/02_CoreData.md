#  CoreData

##  CoreData 이론

- 코어 데이터를 사용하여 오프라인 사용, 임시적인 케쉬등을 위한 영구적인 데이터를 저장할 수 있다. 
- 소규모의 정보를 저장하고 불러오는데 주로 사용
- SQL tool을 통해 실제 저장된 데이터 저장 가능
- 다수의 테이블 생성 및 테이블간 릴레이션 설정 가능

1. [Core Data](https://developer.apple.com/documentation/coredata)
   - 정의
     - 한 디바이스에서 영구 또는 임시적인 데이터나 undo를 지원하기 위한 데이터
     - 오프라인 사용, 임시적인 케쉬 등을 위한 영구적인 데이터를 저장할 수 있음

2. [Creating a Core Data Model](https://developer.apple.com/documentation/coredata/creating_a_core_data_model)
   - Create a data model file to contain your app’s object structure.
3. [Setting Up da Core Data Stack](https://developer.apple.com/documentation/coredata/setting_up_a_core_data_stack)
   - Set up the classes that manage and persist your app’s objects.

![200622_CoreDataStack](../image/02_CoreData/200622_CoreDataStack.png)

- An instance of [`NSManagedObjectModel`](https://developer.apple.com/documentation/coredata/nsmanagedobjectmodel) represents your app’s model file describing your app’s types, properties, and relationships.
- An instance of [`NSManagedObjectContext`](https://developer.apple.com/documentation/coredata/nsmanagedobjectcontext) tracks changes to instances of your app’s types.
- An instance of [`NSPersistentStoreCoordinator`](https://developer.apple.com/documentation/coredata/nspersistentstorecoordinator) saves and fetches instances of your app’s types from stores.
- An instance of [`NSPersistentContainer`](https://developer.apple.com/documentation/coredata/nspersistentcontainer) sets up the model, context, and store coordinator all at once.

4. Fetch flow of data

![200623_coreData_FetchFlowOfData](../image/02_CoreData/200623_coreData_FetchFlowOfData.png)



## CoreData 실 사용 방법

- 아례 예시는 CoreDataManager을 생성하고 singletone 형태로 만들어 해당 프로젝트 내에서 사용 가능하도록 하였음



### CoreDataManager 기본 코드

- AppDelegate.swift

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  lazy var persistentContrainer: NSPersistentContainer = { 
    // 지속적인 데이터를 불러오고 저장할 객체 생성
    let container = NSPersistentContainer(name: <#DBmodelNamm>) // 생성한 DB 모델이름
    
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error {
        fatalError("Unresolved error, \((error as NSError).userInfo)")
      }
      print(storeDescription.url ?? "")
    }
    return container
  }()

  func applicationWillTerminate(_ application: UIApplication) { 
    // 앱이 종료될때 데이터를 저장하는 코드 생성
    CoreDataManager.shared.saveAllData(onSuccess:) { (onSuccess) in
      onSuccess ? print("Save Success") : print("Save fail in Willterminate")
    }
  }
}
```



- CoreDataManager.swift

```swift
class CoreDataManager {
  static let shared: CoreDataManager = CoreDataManager()
  
  let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
	// 앱딜리케이트 에서 생성한 컨테이너 호출
  lazy var context = appDelegate?.persistentContrainer.viewContext 
  
  let modelName: String = "TodoList" // DB 모델의 이름
}

```



### Create

- 신규 데이터 저장 방법

```swift
// 저장할 데이터를 파라미터로 받는 함수를 생성하여 데이터를 저장
func saveTodoItem(createTime: Int, title: String, kinds:String, onSuccess: @escaping ((Bool) -> Void)) {
    if let context = context, 
  		// 저장할 entity 지정
      let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) {
			// 데이터 셋 생성
      if let todoList: TodoList = NSManagedObject(entity: entity, insertInto: context) as? TodoList {
        todoList.createTime = createTime
        todoList.title = title
        todoList.kinds = kinds
        todoList.complete = false
				// 데이터 저장
        contextSave { success in
          onSuccess(success)
        }
      }
    }
  }
```



### Read

- 전체 데이터 추출

  - ```swift
    // CoreData 내부의 모든 데이터 추출
    func fetchTodoList() -> [TodoList] {
      var models: [TodoList] = [] // 임시 모델 생성
    
      if let context = context {
        // sort 옵션 생성 : 오름차순 true
        let createTimeSort: NSSortDescriptor = NSSortDescriptor(key: "createTime", ascending: true)
        // 데이터 모델에 대한 NSFetchRequest 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: modelName)
        fetchRequest.sortDescriptors = [createTimeSort] // sort 옵션 추가
    
        do {  // 데이터 조회 
          if let fetchResult: [TodoList] = try context.fetch(fetchRequest) as? [TodoList] {
            models = fetchResult
          }
        } catch let error as NSError {  // 에러 시 처리 방법
          print("Could not fetch🥺: \(error), \(error.userInfo)")
        }
      }
      return models 	// 결과 값 리턴
    }
    ```

    

- 특정 컬럼의 값만 추출 하는 방법

  - ```swift
    // 추출하고 싶은 특정 칼럼만 함수의 파라미터로 받음
    func fetchKindsTodoList(kinds: String) -> [TodoList] {
        var todoList: [TodoList] = [] // 임시 데이터 보관 장소
       
        if let context = context {
          let sortOption = NSSortDescriptor(key: "createTime", ascending: true) 
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
    			// 특정 칼럼만 조회하도록 설정 추가
          fetchRequest.predicate = NSPredicate(format: " kinds = %@", NSString(string: kinds))
          // sort 옵션 추가
          fetchRequest.sortDescriptors = [sortOption]
    
          do {	// 데이터 추출
            if let fetchResult: [TodoList] = try context.fetch(fetchRequest) as? [TodoList]{
              todoList = fetchResult
            }
          } catch let error as NSError {
            print("Could not fetch🥺: \(error), \(error.userInfo)")
          }
        }
        return todoList
      }
    ```

    

#### Update

1. Read (fetch)를 통해 리턴 받은 데이터를 배열에 저장

2. 해당 배열에서 수정하고 싶은 내용을 수정

3. CoreManger 내에 있는 contextSave 실행

   - ```swift
     contextSave { success in
     	onSuccess(success)
     }
     ```

     

#### Delete

1. Read(fetch)를 통해 리턴 받은 데이터를 배열의 데이터 삭제
2. CoreManager 내의 contextSave 실행



## Reference 

- Apple

  1. [Core Data](https://developer.apple.com/documentation/coredata)

  2. [Creating a Core Data Model](https://developer.apple.com/documentation/coredata/creating_a_core_data_model)
  3. [Setting Up da Core Data Stack](https://developer.apple.com/documentation/coredata/setting_up_a_core_data_stack)

  - [GeneratingCode](https://developer.apple.com/documentation/coredata/modeling_data/generating_code)

- Youtube

  - [Brian Advent - iOS Swift Tutorial: Get started with Core Data and Swift 3 - A Present App](https://www.youtube.com/watch?v=bnxQQgHL1hM)
  - 

