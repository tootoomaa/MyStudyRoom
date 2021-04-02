//
//  HomeView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI

enum MenuType: String, CaseIterable {
    case pocketmon
    case ruler
    case outActivity
    case movableButton
    case dateList
    case circleProgress
    case collectionView
    case timer
    case infomationBlur
    case imageOverlay
    case appleTutorial
    case goodNews
    
    func getView() -> some View {
        switch self {
        case .pocketmon:        return AnyView(PocketmonView())
        case .ruler:            return AnyView(RulerView())
        case .outActivity:      return AnyView(OutActivityView())
        case .movableButton:    return AnyView(MovableButton())
        case .dateList:         return AnyView(DateListView())
        case .circleProgress:   return AnyView(CircleProgressView())
        case .collectionView:   return AnyView(CollectionView())
        case .timer:            return AnyView(TimerView())
        case .infomationBlur:   return AnyView(InformationBlurView())
        case .imageOverlay:     return AnyView(ImageOverlayView())
        case .appleTutorial:    return AnyView(AppleTutorialMainView())
        case .goodNews:         return AnyView(GoodNews())
        }
    }
}

struct Menu: Identifiable {
    let id = UUID().uuidString
    var type: MenuType
}

struct HomeView: View {
    
    @EnvironmentObject var provider: ServiceProvider
    @State var menuList = MenuType.allCases.map(Menu.init)
    @State var isActive = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                NavigationLink(
                    destination: AppleTutorialMainView(),
                    isActive: $isActive,
                    label: {
                        Button(action: {
                            isActive = true
                        }, label: {
                            Text("Apple Turotial")
                                .font(.title)
                                .padding(.leading, 30)
                        })
                    })
                Divider()
                ScrollView {
                    Divider()
                    ForEach(menuList) { menu in
                        VStack(alignment: .leading) {
                            NavigationLink(
                                destination: menu.type.getView(),
                                label: {
                                    Text(menu.type.rawValue)
                                        .padding(.leading, 30)
                                })
                            
                            Divider()
                        }
                    }
                }
            }.navigationBarTitle("Examples")
        }
        .accentColor(.black)
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            provider.newsService.getGoodNews()
        }
    }
    
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
