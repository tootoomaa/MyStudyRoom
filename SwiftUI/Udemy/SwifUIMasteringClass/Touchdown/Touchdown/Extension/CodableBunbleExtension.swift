//
//  CodableBunbleExtension.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        
        // 1. Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Fail to load \(file) from url")
        }
        
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Fail to get data")
        }
    
        // 3. Create a decoder
        let decode = JSONDecoder()
        
        // 4. Create a properties for the Decoded DAta
        guard let decoededData = try? decode.decode(T.self, from: data) else {
            fatalError("Fail to decode from data")
        }
        
        // 5. Return the ready-to-use data
        return decoededData
    }
    
}
