//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by 김광수 on 2022/09/01.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
