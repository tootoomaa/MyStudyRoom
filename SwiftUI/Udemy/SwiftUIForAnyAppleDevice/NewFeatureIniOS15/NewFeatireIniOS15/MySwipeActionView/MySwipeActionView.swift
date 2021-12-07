//
//  MySwipeActionView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct MySwipeActionView: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { index in
                Text("\(index)")
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            // action
                        } label: {
                            if index % 2 == 0 {
                                Label("Read", systemImage: "envelope.open")
                                    .labelStyle(.titleOnly)
                            } else {
                                Label("Unread", systemImage: "envelope.badge")
                                    .labelStyle(.iconOnly)
                            }
                        } //: Swipe action Leading
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            // action
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } //: Swipe action Trailing
            } //: ForEach
        } //: List
        .listStyle(PlainListStyle())
    }
}

struct MySwipeActionView_Previews: PreviewProvider {
    static var previews: some View {
        MySwipeActionView()
    }
}
