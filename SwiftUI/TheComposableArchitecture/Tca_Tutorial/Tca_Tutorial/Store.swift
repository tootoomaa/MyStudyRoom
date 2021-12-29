//
//  Store.swift
//  Tca_Tutorial
//
//  Created by 김광수 on 2021/12/29.
//

import Foundation
import ComposableArchitecture

let appStore = Store(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment(
        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
        numberFact: { number in
            Effect(value: "\(number) is a good number")
        }
    )
)
