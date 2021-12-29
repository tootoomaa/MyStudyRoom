//
//  Action.swift
//  Tca_Tutorial
//
//  Created by 김광수 on 2021/12/29.
//

import Foundation

enum AppAction: Equatable {
    case factAlertDismissed
    case decrementButtonTapped
    case incrementButtonTapped
    case numberFactButtonTapped
    case numberFactResponse(Result<String, ApiError>)
}

struct ApiError: Error, Equatable { }
