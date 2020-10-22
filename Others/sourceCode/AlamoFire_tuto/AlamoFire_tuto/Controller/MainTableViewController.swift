//
//  MainTableViewController.swift
//  AlamoFire_tuto
//
//  Created by 김광수 on 2020/10/22.
//

import Foundation
import Alamofire
import UIKit

class MainTableViewController: UIViewController {
  
  var items: [Displayable] = []
  var selectedItem: Displayable?
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchFilms()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard let detailFilmVC = segue.destination as? DetailFilmViewContoller else { return }
    detailFilmVC.selectedItem = self.selectedItem
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
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
    
    let item = items[indexPath.row]
    cell.textLabel?.text = item.titleLabelText
    cell.detailTextLabel?.text = item.subtitleLabelText
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    selectedItem = items[indexPath.row]
    return indexPath
  }
}

// MARK: - Network
extension MainTableViewController {
  
  func fetchFilms() {
    let url = URL(string: "https://swapi.dev/api/films")!
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        print("Error", error.localizedDescription)
        return
      }
      guard let data = data else { return }
      
      if let parsingData = try? JSONDecoder().decode(Films.self, from: data) {
        self.items = parsingData.all
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }.resume()
    
    
    AF.request("https://swapi.dev/api/films")
      .validate(statusCode: 200..<300)
      .responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else { return }
        self.items = films.all
        self.tableView.reloadData()
      }
  }
  
  func searchStarships(for name: String) {
    // 1
    let url = "https://swapi.dev/api/starships"
    // 2
    let parameters: [String: String] = ["search": name]
    // 3
    AF.request(url, parameters: parameters)
      .validate()
      .responseDecodable(of: Starships.self) { response in
        // 4
        guard let starships = response.value else { return }
        self.items = starships.all
        self.tableView.reloadData()
    }
  }

}
