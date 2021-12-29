//
//  AppEnvironment.swift
//  Tca_Tutorial
//
//  Created by 김광수 on 2021/12/29.
//

import Foundation
import CombineSchedulers
import ComposableArchitecture

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var numberFact: (Int) -> Effect<String, ApiError>
}
