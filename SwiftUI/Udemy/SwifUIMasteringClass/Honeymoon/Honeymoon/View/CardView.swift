//
//  CardView.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

struct CardView: View, Identifiable {
    // MARK: - Properties
    let id = UUID()
    var honeymoon: Destination
    
    // MARK: - Body
    var body: some View {
        Image(honeymoon.image)
            .resizable()
            .cornerRadius(24)
            .scaledToFit()
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(
                VStack(alignment: .center, spacing: 12) {
                    Text(honeymoon.place.uppercased())
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay(
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 1),
                            alignment: .bottom
                                
                        )
                    Text(honeymoon.country.uppercased())
                        .foregroundColor(Color.black)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(minWidth: 85)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule().fill(Color.white)
                        )
                }
                .frame(minWidth: 280)
                .padding(.bottom, 50),
                alignment: .bottom
            )
    }
}

// MARK: - Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(honeymoon: HoneymoonData[1])
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
