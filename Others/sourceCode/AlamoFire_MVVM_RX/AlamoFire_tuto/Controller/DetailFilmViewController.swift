//
//  DetailFilmViewController.swift
//  AlamoFire_tuto
//
//  Created by 김광수 on 2020/10/22.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import RxCocoa

class DetailFilmViewContoller: UIViewController {
  
  var selectedFilm: FilmViewModel?
  var selectedStarship: StarshipViewModel?
  
  var listData: [Displayable] = []
  
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var filmTitleLabel: UILabel!
  @IBOutlet weak var filmSubtitle: UILabel!
  
  @IBOutlet weak var item1Label: UILabel!
  @IBOutlet weak var item1ValueLabel: UILabel!
  
  @IBOutlet weak var item2Label: UILabel!
  @IBOutlet weak var item2ValueLabel: UILabel!
  
  @IBOutlet weak var item3Label: UILabel!
  @IBOutlet weak var item3ValueLabel: UILabel!
  
  @IBOutlet weak var itemTitle: UILabel!
  
  @IBOutlet weak var listTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    commonInit()
    fetchStarshipList()
    fetchFilmList()
  }
  
  private func commonInit() {
    guard let data = selectedFilm else { return }
    
    data.titleLabelText.asDriver(onErrorJustReturn: "")
      .drive(filmTitleLabel.rx.text)
      .disposed(by: disposeBag)
    
    data.item1LabelText.asDriver(onErrorJustReturn: "")
      .drive(item1Label.rx.text)
      .disposed(by: disposeBag)
    
    data.item1ValueText.asDriver(onErrorJustReturn: "")
      .drive(item1ValueLabel.rx.text)
      .disposed(by: disposeBag)
    
    data.item2LabelText.asDriver(onErrorJustReturn: "")
      .drive(item2Label.rx.text)
      .disposed(by: disposeBag)
    
    data.item2ValueText.asDriver(onErrorJustReturn: "")
      .drive(item2ValueLabel.rx.text)
      .disposed(by: disposeBag)
    
    data.item3LabelText.asDriver(onErrorJustReturn: "")
      .drive(item3Label.rx.text)
      .disposed(by: disposeBag)
    
    data.item3ValueText.asDriver(onErrorJustReturn: "")
      .drive(item3ValueLabel.rx.text)
      .disposed(by: disposeBag)
    
    data.listTitle.asDriver(onErrorJustReturn: "")
      .drive(itemTitle.rx.text)
      .disposed(by: disposeBag)
  }
  
  func fetchStarshipList() {
    guard let data = selectedFilm?.film else { return }
    fetch(data.listItems, of: Starship.self)
  }
  
  func fetchFilmList() {
    guard let data = selectedStarship?.starship else { return }
    fetch(data.films, of: Film.self)
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
