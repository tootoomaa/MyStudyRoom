//
//  CodableBunbleExtension.swift
//  Africa
//
//  Created by 김광수 on 2021/04/08.
//

import Foundation

extension Bundle {
    func decode<T: Codable & Identifiable>(_ file: String) -> [T] {
        
        // 1. Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Fail to locate \(file) in bundle")
        }
        
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Fail to load \(file) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decode data
        guard let loaded = try? decoder.decode([T].self, from: data) else {
            fatalError("Fail to decode \(file) from bundle.")
        }
        
        // 5. Return the ready-to-use data
        return loaded
    }
}
