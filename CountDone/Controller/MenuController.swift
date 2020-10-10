//
//  MenuController.swift
//  CountDone
//
//  Created by Changyu on 10/10/20.
//  Copyright © 2020 G33. All rights reserved.
//
// reference: https://www.youtube.com/watch?v=dB-vB9uDRCI

import UIKit

private let reuseIdentifer = "MenuOptionCell"

class MenuController: UIViewController {
    
    // MARK: -Properties
    
    var tableView: UITableView!
    
    // MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: -Handlers
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
        return cell
    }
    
    
}

