//
//  ProfileViewController.swift
//  CountDone
//
//  Created by Changyu on 2/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, Storyboarded {
    var coordinator: ProfileFlow?
    
    var userAccount = [UserAccount]() //
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rest = REST_Request()
    }
    

}
