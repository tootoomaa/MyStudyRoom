import Combine


Just(5).sink {
    print($0)
}

let provider = (1...10).publisher


provider.sink(
    receiveCompletion: <#T##((Subscribers.Completion<Never>) -> Void)##((Subscribers.Completion<Never>) -> Void)##(Subscribers.Completion<Never>) -> Void#>,
    receiveValue: <#T##((ClosedRange<Int>.Element) -> Void)##((ClosedRange<Int>.Element) -> Void)##(ClosedRange<Int>.Element) -> Void#>)

provider.sink { _ in
    print("데이터 전달이 끝났습니다.")
} receiveValue: { data in
    print(data)
}

