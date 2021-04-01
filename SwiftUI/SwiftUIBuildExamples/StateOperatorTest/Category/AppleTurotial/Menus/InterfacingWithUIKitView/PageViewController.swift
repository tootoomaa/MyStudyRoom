//
//  PageViewController.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    var pages: [Page]

    func makeUIViewController(context: Context) -> some UIViewController {
        let pageViewcontroller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        return pageViewcontroller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        [UIHostingController(rootView: pages[0])], direction: .forward, animated: true)
    }
}
