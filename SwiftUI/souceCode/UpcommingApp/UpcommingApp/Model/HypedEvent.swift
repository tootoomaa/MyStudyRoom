//
//  HypedEvent.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import Foundation
import SwiftUI
import SwiftDate
import UIColor_Hex_Swift

class HypedEvent: Identifiable, ObservableObject, Codable {
    
    var id = UUID().uuidString
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple
    @Published var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case url
        case color
        case imageData
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(date, forKey: CodingKeys.date)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(url, forKey: CodingKeys.url)
        try container.encode(UIColor(color).hexString(), forKey: CodingKeys.color)
        try container.encode(imageData, forKey: CodingKeys.imageData)
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try value.decode(String.self, forKey: .id)
        self.date = try value.decode(Date.self, forKey: .date)
        self.title = try value.decode(String.self, forKey: .title)
        self.url = try value.decode(String.self, forKey: .url)
        
        let colorHext = try value.decode(String.self, forKey: .color)
        self.color = Color(UIColor(colorHext))
        
        self.imageData = try? value.decode(Data.self, forKey: .imageData)
        
    }
    
    func image() -> Image? {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
    
    func dataAsString() -> String {
        let formatter = DateFormatter()
        
        if date.compare(.isThisYear) {
            formatter.dateFormat = "MMM d"
        } else {
            formatter.dateFormat = "MMM d yyyy"
        }
        
        return formatter.string(from: date)
    }
    
    func timeFromNow() -> String {
        return date.toRelative()
    }
}

var testHypedEvent1: HypedEvent {
    let hypedEvent = HypedEvent()
    
    if let data = UIImage(named: "wwdc")?.pngData() {
        hypedEvent.imageData = data
    }
    
    hypedEvent.title = "WWDC2021"
    hypedEvent.url = "apple.com"
    hypedEvent.color = .green
    hypedEvent.date = Date()
    
    return hypedEvent
}

var testHypedEvent2: HypedEvent {
    let hypedEvent = HypedEvent()
    
    hypedEvent.title = "Family Trip"
    hypedEvent.color = .blue
    hypedEvent.date = Date() + 4.days + 1.years
    
    return hypedEvent
}
