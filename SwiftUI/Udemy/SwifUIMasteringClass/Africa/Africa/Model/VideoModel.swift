//
//  VideoModel.swift
//  Africa
//
//  Created by 김광수 on 2021/04/11.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    var thumbnail: String {
        "video-\(id)"
    }
}

//{
//  "id" : "elephant",
//  "name" : "Elephant",
//  "headline" : "African elephant with calf walking"
//},
