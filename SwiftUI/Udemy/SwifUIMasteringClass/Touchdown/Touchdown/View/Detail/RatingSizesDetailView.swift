//
//  RatingSizesDetailView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/15.
//

import SwiftUI

struct RatingSizesDetailView: View {
    //MARK: - Properties
    let sizes: [String] = ["XS", "S", "M", "L"]
    
    //MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 3, content: {
            // RAINGS
            VStack(alignment: .leading, spacing: 3, content: {
                Text("Ragings")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(colorGray)
                
                HStack(alignment: .center, spacing: 3, content: {
                    ForEach(1...5, id: \.self) { item in
                        Image(systemName: "star.fill")
                            .frame(width: 28, height: 28, alignment: .center)
                            .background(colorGray.cornerRadius(5))
                            .foregroundColor(.white)
                    }//: Loop
                })
            }) //: VSTACK
            
            Spacer()
            
            //Sizes
            VStack(alignment: .trailing, spacing: 3, content: {
                Text("Sizes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(colorGray)
                
                HStack(alignment: .center, spacing: 5, content: {
                    ForEach(sizes, id: \.self) { size in
                        Button(action: {
                            
                        }, label: {
                            Text(size)
                                .font(.footnote)
                                .fontWeight(.heavy)
                                .foregroundColor(colorGray)
                                .frame(width: 28, height: 28, alignment: .center)
                                .background(Color.white.cornerRadius(5))
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(colorGray, lineWidth: 2)
                                )
                        })
                    } //: LOOP
                }) //: HSTACK
                
            }) //: VSTACK
            
            
        }) //: HSTACK
    }
}

//MARK: - Preview
struct RatingSizesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RatingSizesDetailView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
