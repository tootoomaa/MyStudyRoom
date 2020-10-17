//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by 김광수 on 2020/10/16.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
  // MARK: - Properties
  let disposeBag = DisposeBag()
  private var articleListVM: ArticleListViewModel!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationBar()
    populateNews()
  }
  
  private func configureNavigationBar() {
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    let apperance = UINavigationBarAppearance()
    apperance.backgroundColor = UIColor(displayP3Red: 142/255, green: 68/255, blue: 173/255, alpha: 1.0)
    
    apperance.largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
    apperance.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
    self.navigationController?.navigationBar.compactAppearance = apperance
    self.navigationController?.navigationBar.scrollEdgeAppearance = apperance
    self.navigationController?.navigationBar.standardAppearance = apperance
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articleListVM == nil ? 0 : self.articleListVM.articlesVM.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("Can't found ArticleTableViewCell")}
    
    let articleVM = self.articleListVM.articleAt(indexPath.row)
    
    articleVM.title.asDriver(onErrorJustReturn: "")
      .drive( cell.titleLabel.rx.text )
      .disposed(by: disposeBag)

    articleVM.description.asDriver(onErrorJustReturn: "")
      .drive( cell.descriptionLabel.rx.text )
      .disposed(by: disposeBag)
    
    return cell
  }
  
  private func populateNews() {
    
    let resouce = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=aab00f244cdd43558a60ae6c73002474")!)
    
    URLRequest.load(resource: resouce)
      .subscribe(onNext: { articleResponse in
        
        let articles = articleResponse.articles
        self.articleListVM = ArticleListViewModel(articles)
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        
      }).disposed(by: disposeBag)
    
  }
  
}
