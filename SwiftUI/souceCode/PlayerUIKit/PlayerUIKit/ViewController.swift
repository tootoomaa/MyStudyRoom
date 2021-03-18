//
//  ViewController.swift
//  PlayerUIKit
//
//  Created by 김광수 on 2021/01/31.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "Player List"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = players[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let playerDetail = PlayerDetail(player: players[indexPath.row])
        
//        let vc = PlayerDetailVC()
        
        let vc = UIHostingController(rootView: playerDetail)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

