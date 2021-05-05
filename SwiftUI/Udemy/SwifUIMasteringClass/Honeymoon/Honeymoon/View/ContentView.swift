//
//  ContentView.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @GestureState private var dragState = DragState.inactive
    private var dragAreaThreshold: CGFloat = 65
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.tailingBotton
    
    // MARK: - CardViews
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymoon: HoneymoonData[index]))
        }
        return views
    }()
    
    // MARK: - Move The Card
    
    private func moveCards() {
        cardViews.removeFirst()
        self.lastCardIndex += 1
        
        let honeymoon = HoneymoonData[lastCardIndex % HoneymoonData.count]
        let newCardView = CardView(honeymoon: honeymoon)
        cardViews.append(newCardView)
    }
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Header
            HeaderView(showGuide: $showGuide, showInfo: $showInfo)
                .opacity(dragState.isDragging ? 0.0 : 1.0 )
                .animation(.default)
            
            Spacer()
            
            // MARK: - Cards
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            //X- Mark
                            ZStack {
                                Image(systemName: "x.circle")
                                    .modifier(SimbolModifier())
                                    .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                
                                Image(systemName: "heart.circle")
                                    .modifier(SimbolModifier())
                                    .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                            }
                        )
                        .offset(
                            x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0,
                            y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0
                        )
                        .scaleEffect(self.dragState.isDragging ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ?
                                            Double(self.dragState.translation.width/12) : 0 ))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                        .sequenced(before: DragGesture())
                        .updating(self.$dragState, body: { (value, state, transaction) in
                            switch value {
                            case .first(true):
                                state = .pressing
                            case .second(true, let drag):
                                state = .dragging(translation: drag?.translation ?? .zero)
                            default:
                                break
                            }
                        })
                        .onChanged({ value in // 카드를 좌우로 움직이면 카드가 아래로 내려가는 에니메이션
                            guard case .second(true, let drag?) = value else {
                                return
                            }
                            
                            if drag.translation.width < -self.dragAreaThreshold {
                                self.cardRemovalTransition = .leadingButton
                            }
                            
                            if drag.translation.width > self.dragAreaThreshold {
                                self.cardRemovalTransition = .tailingBotton
                            }
                        })
                        .onEnded({ (value) in
                            guard case .second(true, let drag?) = value else {
                                return
                            }
                            if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                playSound(sound: "sound-rise", type: "mp3")
                                self.moveCards()
                            }
                        })
                    )
                    .transition(self.cardRemovalTransition)
                        
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - Footer
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0 )
                .animation(.default)
        } //: VSTACL
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("SUCESS"),
                message: Text("Wishing a lovely and most precious of the time together for the amazing couple"),
                dismissButton: .default(Text("Happy Honeymoon!"))
            )
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
