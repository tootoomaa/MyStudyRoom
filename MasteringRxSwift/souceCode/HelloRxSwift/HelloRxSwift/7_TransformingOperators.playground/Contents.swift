import Cocoa
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

print("\n==== [ toArray ] ====\n")
Observable.of(1,2,3,4,5)
  .toArray()
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ Map ] ====\n")
Observable.of(1,2,3,4,5)
  .map { $0 * 2 }
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ flapMap ] ====\n")

struct Student {
  var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()

student.asObservable()
  .flatMap { $0.score.asObservable() }
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

student.onNext(john)
john.score.accept(100)

student.onNext(mary)
mary.score.accept(90)

//student.asObservable()
//  .flatMapLatest { $0.score.asObservable() }
//  .subscribe( onNext: {
//    print($0)
//  }).disposed(by: disposeBag)
//
//student.onNext(john)
//john.score.accept(100)
//
//student.onNext(mary)
//john.score.accept(45) // ignore


