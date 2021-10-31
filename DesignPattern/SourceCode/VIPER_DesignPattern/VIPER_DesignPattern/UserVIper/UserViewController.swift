//
//  View.swift
//  VIPER_DesignPattern
//
//  Created by 김광수 on 2021/10/31.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter

protocol AnyView {
    var presentor: AnyPresenter?    { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    
    var presentor: AnyPresenter?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.text = "is Empty"
        return label
    }()
    
    var users: [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with users: [User]) {
        print(users)
        DispatchQueue.main.async {
            self.users = users
            self.tableView.isHidden = false
            self.label.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.users = []
            self.tableView.isHidden = true
            self.label.isHidden = false
            self.tableView.reloadData()
        }
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
}
