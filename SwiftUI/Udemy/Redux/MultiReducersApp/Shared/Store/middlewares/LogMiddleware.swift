//
//  LogMiddleware.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import Foundation

func logMiddleware() -> Middleware<AppState> {
    
    return { state, action, dispatch in
        print("[LOG MIDDLEWARE]")
    }
}
