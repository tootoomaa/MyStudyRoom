//
//  Hike.swift
//  Hiking
//
//  Created by 김광수 on 2021/10/11.
//

import Foundation

struct Hike {
    let name: String
    let imageURL: String
    let miles: Double
}

extension Hike {
    
    static func all() -> [Hike] {
        
        return [
            Hike(name: "Salmonbeey Trail", imageURL: "1", miles: 6),
            Hike(name: "Tom, Dic Trail", imageURL: "2", miles: 5.7),
            Hike(name: "My Custom Trail", imageURL: "3", miles: 7)
        
        ]
        
    }
    
}
