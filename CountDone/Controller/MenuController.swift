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

class MenuController: UIViewController, Storyboarded {
    
    // MARK: -Properties
    
    var coordinator: MenuFlow?
    var ecoordinator: EventFlow?
    
    var userButton: UIButton!
    var tagButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    
    // MARK: -Init

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back() {
        ecoordinator?.backToEvent()
    }
//        configureTableView()

    
    
//    // MARK: -Handlers
//
//    func configureTableView() {
//        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
//        tableView.backgroundColor = .darkGray
//        tableView.separatorStyle = .none
//        tableView.rowHeight = 80
//
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    }
}

//extension MenuController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
//        return cell
//    }
//    
//    
//}

