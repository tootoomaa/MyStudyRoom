//
//  FilterButtonView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

enum TweetFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweets:   return "Tweets"
        case .replies:  return "Tweets & Replies"
        case .likes:    return "Likes"
        }
    }
}

struct FilterButtonView: View {
    // MARK: - Properties
    @State var selectedOptionWithAnimation: TweetFilterOptions = TweetFilterOptions.tweets
    @Binding var selectedOption: TweetFilterOptions
    
    private let underlineWidth = UIScreen.main.bounds.width / CGFloat(TweetFilterOptions.allCases.count)
    
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        let count = CGFloat(TweetFilterOptions.allCases.count)
        return ((UIScreen.main.bounds.width/count) * rawValue) + 16
    }
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                ForEach(TweetFilterOptions.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                        self.selectedOptionWithAnimation = option
                    }, label: {
                        Text(option.title)
                            .frame(width: underlineWidth - 8)
                            .font(.system(size: 14))
                    })
                    Spacer()
                } //: FOREACH
            } //: HSTACK
            
            Rectangle()
                .frame(width: underlineWidth - 32, height: 3, alignment: .center)
                .foregroundColor(.blue)
                .animation(.spring())
                .padding(.leading, 20)
                .offset(x: CGFloat(selectedOptionWithAnimation.rawValue) * underlineWidth)
        } //: VSTACK
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilterButtonView(selectedOption: .constant(.tweets))
            
            FilterButtonView(selectedOption: .constant(.replies))
        }
        .previewLayout(.sizeThatFits)
    }
}
