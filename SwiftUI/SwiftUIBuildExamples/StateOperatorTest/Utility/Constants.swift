//
//  Constants.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI

class Constants {
    
    static let viewWitdh = UIScreen.main.bounds.width
    static let viewHeight = UIScreen.main.bounds.height
    
    // Statictic
    enum duration: Int, CaseIterable {
        case weak = 0
        case month = 1
        
        func getDayForStatistics() -> Double {
            switch self {
            case .month:
                return 30.0
            case .weak:
                return 7.0
            }
        }
    }
}
