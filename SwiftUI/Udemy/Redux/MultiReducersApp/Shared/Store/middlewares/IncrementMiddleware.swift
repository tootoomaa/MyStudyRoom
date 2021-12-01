//
//  IncrementMiddleware.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import Foundation
import SwiftUI

func incrementMiddleware() -> Middleware<AppState> {
    
    return { state, action, dispatch in
        
        switch action {
        case _ as IncrementActionAsync:
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                print("IncrementActionAsync")
                dispatch(IncrementAction())
            }
        default:
            break
        }
        
    }
}
