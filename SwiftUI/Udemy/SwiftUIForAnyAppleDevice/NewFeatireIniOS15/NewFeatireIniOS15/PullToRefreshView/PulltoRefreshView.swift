//
//  PulltoRefreshView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct PulltoRefreshView: View {
    
    @ObservedObject var cutomerListVM = CustomerListViewModel()
    
    var body: some View {
        List(cutomerListVM.customers, id: \.self) { customer in
            Text(customer)
        }
        .onAppear       { self.cutomerListVM.fetch() }  // 최초 실행시 실행
        .refreshable    { self.cutomerListVM.fetch() }  // 아래로 새로고침 시 실행
    }
}

struct PulltoRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PulltoRefreshView()
    }
}
