//
//  WebViewController.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/21.
//

import Foundation
import UIKit
import WebKit
import SnapKit
import Then

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
  
  let webView = WKWebView()
  
  let segmentController = UISegmentedControl(items: ["이용약관","프라이버시 폴리시"]).then {
    
    $0.setTitleTextAttributes(
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)

    $0.setTitleTextAttributes(
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], for: .selected)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    checkNetworkConnect()
    
    view.backgroundColor = .white
    
    view.addSubview(webView)
    view.addSubview(segmentController)
    
    segmentController.addTarget(self, action: #selector(tapSegmentC), for: .valueChanged)
    
    segmentController.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(50)
    }
    
    webView.snp.makeConstraints {
      $0.top.equalTo(segmentController.snp.bottom).offset(10)
      $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    webView.uiDelegate = self
    webView.navigationDelegate = self
  }
  
  @objc func tapSegmentC() {
    
    let urlFirst = URL(string: "https://github.com/tootoomaa/MyStudyRoom/blob/master/Others/note/15_UINavigationBarAppearance.md")!
    let urlSecond = URL(string: "https://www.notion.so/Segment-Controller-28ef58261be74d468f9f702482f58a20")!
    
    if segmentController.selectedSegmentIndex == 0 {
      let request = URLRequest(url: urlFirst)
      webView.load(request)
    } else {
      let request = URLRequest(url: urlSecond)
      webView.load(request)
    }
  }
  
  private func checkNetworkConnect() {
    
    if Reachability.isConnectedToNetwork() {
      print("Network Connect")
    } else {
      print("Network Not Connect")
      
      let networkCheckAlert = UIAlertController(title: "NetworkError",
                                                message: "앱을 종료합니다",
                                                preferredStyle: .alert)
      networkCheckAlert
        .addAction(UIAlertAction(title: "OK",
                                 style: .default,
                                 handler: { (action) in
                                    print("App exit")
                                    exit(0)
                                 }))
      self.present(networkCheckAlert, animated: true, completion: nil)
    }
    
  }
  // WKNavigationDelegate 중복적으로 리로드 방지( iOS 9 이후지원 )
  func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
    webView.reload()
  }
  
}
