//
//  RipeningStagesView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/23.
//

import SwiftUI

struct RipeningStagesView: View {
    // MARK: - Properties
    var ripeningStages: [Ripening] = ripeningsData
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Spacer()
            HStack(alignment: .center, spacing: 25) {
                ForEach(ripeningStages) { ripening in
                    RipeningView(ripening: ripening)
                }
            } //: HSTACK
            .padding(.horizontal, 25)
            .padding(.vertical)
            Spacer()
        } //: Scrollview
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - PreView
struct RipeningStagesView_Previews: PreviewProvider {
    static var previews: some View {
        RipeningStagesView()
    }
}
