//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
  
  private var articleListVM: ArticleListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=aab00f244cdd43558a60ae6c73002474")!
    
    WebServices().getArticles(url: url) { articles in
      
      if let articles = articles {
        
        self.articleListVM = ArticleListViewModel(articles: articles)
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        
      }
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSection
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articleListVM.numberOfRowInSection(section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("Can't find ArticleTableViewCell") }
    
    cell.titleLabel.text = self.articleListVM.articleAtIndex(indexPath.row).title
    cell.descriptionLabel.text = self.articleListVM.articleAtIndex(indexPath.row).description ?? ""
    
    return cell
  }
  
  private func setup() {
    
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .systemPurple
    appearance.largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
    appearance.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
    self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    self.navigationController?.navigationBar.compactAppearance = appearance
    self.navigationController?.navigationBar.standardAppearance = appearance
    
  }
  
  
}
