//
//  BrockenRulesView.swift
//  PasswordValidationApp
//
//  Created by 김광수 on 2021/12/07.
//

import SwiftUI

struct BrockenRulesView: View {
    
    let brokenRules: [BrokenRule]
    
    var body: some View {
        ForEach(brokenRules, id: \.id) { rule in
            Text(rule.message)
        }
    }
}

struct BrockenRulesView_Previews: PreviewProvider {
    static var previews: some View {
        BrockenRulesView(brokenRules: [])
    }
}
