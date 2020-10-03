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
    
    var profiles = [Profile]() //
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        // request to fetch data
        let request: NSFetchRequest<Profile> = Profile.profileFetchRequest()
        
        // fetch data
        do {
            let profiles = try CoreDataStack.shared.context.fetch(request)
            self.profiles = profiles
        } catch {}
        
        tableView.reloadData()
    }
    
    
    
    
}
