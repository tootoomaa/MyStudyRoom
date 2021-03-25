//
//  CounterViewModel.swift
//  HelloMVVM
//
//  Created by 김광수 on 2021/03/24.
//

import Foundation
import SwiftUI

/*
 ObservableObject - SwiftUI Combind
 Observable 객체를 생성해주고, 변경 사항이 있으면 값을 보내준다.
 Struct는 상속이 안됨으로 Class만 가능
 
 */
class CounterViewModel: ObservableObject {
    
    // counter 변수가 변경되면 Publicsh로 정의된 변수를 알린다
    @Published private var counter = Counter()
    
    var value: Int {
        counter.value
    }
    
    var premium: Bool {
        counter.isPremeum
    }

    func addValue() {
        counter.increment()
    }
    
}
