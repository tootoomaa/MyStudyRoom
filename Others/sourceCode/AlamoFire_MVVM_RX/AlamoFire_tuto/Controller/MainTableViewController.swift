//
//  MainTableViewController.swift
//  AlamoFire_tuto
//
//  Created by 김광수 on 2020/10/22.
//

import Foundation
import Alamofire
import UIKit
import RxSwift
import RxCocoa

class MainTableViewController: UIViewController {
  
  var filmItems: FilmListViewModel?
  var starshipItems: StarshipListViewModel?
  
  var selectedFilm: FilmViewModel?
  var selectedStarShip: StarshipViewModel?
  
  
  let disposbag = DisposeBag()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchFilms()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard let detailFilmVC = segue.destination as? DetailFilmViewContoller else { return }
    detailFilmVC.selectedFilm = selectedFilm
  }
}

// MARK: - SearchBar
extension MainTableViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    searchStarships(for: searchText)
  }
  
}


// MARK: - TableViewDataSource & TableViewDelegate
extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filmItems?.films.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
    
    let filmItem = filmItems?.filmAt(indexPath.row)
    
    filmItem?.titleLabelText.asDriver(onErrorJustReturn: "")
      .drive(cell.textLabel!.rx.text)
      .disposed(by: disposbag)
    
    filmItem?.subtitleLabelText.asDriver(onErrorJustReturn: "")
      .drive(cell.detailTextLabel!.rx.text)
      .disposed(by: disposbag)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    selectedFilm = filmItems?.filmAt(indexPath.row)
    return indexPath
  }
}

// MARK: - Network
extension MainTableViewController {
  
  func fetchFilms() {
    AF.request("https://swapi.dev/api/films")
      .validate(statusCode: 200..<300)
      .responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else { return }
        self.filmItems = FilmListViewModel(films.all)
        self.tableView.reloadData()
      }
  }
  
  func searchStarships(for name: String) {
    
    let url = "https://swapi.dev/api/starships"
    
    let parameters: [String: String] = ["search": name]

    AF.request(url, parameters: parameters)
      .validate()
      .responseDecodable(of: Starships.self) { response in
        // 4
        guard let starships = response.value else { return }
        self.starshipItems = StarshipListViewModel(starships.all)
        self.tableView.reloadData()
    }
  }

}
