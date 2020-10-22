//
//  DetailFilmViewController.swift
//  AlamoFire_tuto
//
//  Created by 김광수 on 2020/10/22.
//

import Foundation
import UIKit
import Alamofire

class DetailFilmViewContoller: UIViewController {
  
  var selectedItem: Displayable?
  var listData: [Displayable] = []
  
  @IBOutlet weak var filmTitleLabel: UILabel!
  @IBOutlet weak var filmDerectorLabel: UILabel!
  @IBOutlet weak var filmProducerLabel: UILabel!
  @IBOutlet weak var filmReleaseLabel: UILabel!
  @IBOutlet weak var filmEpisodeLabel: UILabel!
  
  @IBOutlet weak var listTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    commonInit()
    fetchList()
  }
  
  private func commonInit() {
    guard let data = selectedItem else { return }
    
    filmTitleLabel.text = data.titleLabelText
    filmEpisodeLabel.text = data.subtitleLabelText

    filmProducerLabel.text = data.item1.value
    
    filmDerectorLabel.text = data.item2.value
    
    filmReleaseLabel.text = data.item3.value
  }
  
  func fetchList() {
    
    guard let data = selectedItem else { return }
    
    switch data {
    case is Film:
      fetch(data.listItems, of: Starship.self)
    case is Starship:
      fetch(data.listItems, of: Film.self)
    default:
      print("Unknown Type: ", String(describing: type(of: data)))
    }
    
  }
}

// MARK: - TableViewDataSource
extension DetailFilmViewContoller: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFilmTableViewCell", for: indexPath)
    
    cell.textLabel?.text = listData[indexPath.row].titleLabelText
    
    return cell
  }
}


// MARK: - Network
extension DetailFilmViewContoller {
  
  private func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type) {
    
    var items: [T] = []
    
    let fetchGroup = DispatchGroup()
    
    list.forEach { url in
      
      fetchGroup.enter()
      
      AF.request(url)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { (response) in
          if let value = response.value {
            items.append(value)
          }
          
          fetchGroup.leave()
        }
    }
    
    fetchGroup.notify(queue: .main) {
      self.listData = items
      self.listTableView.reloadData()
    }
  }
}
