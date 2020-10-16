//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by 김광수 on 2020/10/15.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
  
  let disposeBag = DisposeBag()
  
  private var articles = [Article]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    configureNavigationController()
    populateNews()
    
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articles.count
  }
   
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("Artical TableView Cell is not Exist") }
    
    cell.titleLabel.text = self.articles[indexPath.row].title
    cell.contentLabel.text = articles[indexPath.row].description
    
    return cell
  }
  
  private func configureNavigationController() {
    
    let naviBackGroundColor = UIColor(displayP3Red: 47/255, green: 54/255, blue: 64/255, alpha: 1.0)
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = naviBackGroundColor
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }
  
  private func populateNews() {
    
//    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=aab00f244cdd43558a60ae6c73002474")!
//    let resource = Resource<ArticlesList>(url: url)
    
    URLRequest.load(resource: ArticlesList.all)
      .subscribe(onNext: { [weak self] result in
        if let result = result {
          self?.articles = result.articles
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
        }
      }).disposed(by: disposeBag)
    
//    Observable.just(url)
//      .flatMap { url -> Observable<Data> in
//        let request = URLRequest(url: url)
//        return URLSession.shared.rx.data(request: request)
//      }.map { data -> [Article]? in
//        return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
//      }.subscribe(onNext: { [weak self] articleArray in
//
//        if let articleArray = articleArray {
//          self?.articles = articleArray
//          DispatchQueue.main.async {
//            self?.tableView.reloadData()
//          }
//        }
//
//      }).disposed(by: disposeBag)
  }
}
