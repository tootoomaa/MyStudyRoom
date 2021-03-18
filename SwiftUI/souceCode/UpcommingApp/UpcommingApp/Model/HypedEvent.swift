//
//  HypedEvent.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import Foundation
import SwiftUI

class HypedEvent: ObservableObject {
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple
    var imageData: Data?
}
