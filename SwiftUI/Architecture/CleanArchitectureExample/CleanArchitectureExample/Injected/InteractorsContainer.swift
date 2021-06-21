//
//  InteractorsContainer.swift
//  CleanArchitectureExample
//
//  Created by 김광수 on 2021/06/06.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let displayNumberInspactor: DisplayNumberInspactor
        
        init(displayNumberInspactor: DisplayNumberInspactor) {
            self.displayNumberInspactor = displayNumberInspactor
        }
        
        static var stub: Self {
            .init(displayNumberInspactor: StubDisplayNumberInspactor())
        }
    }
}
