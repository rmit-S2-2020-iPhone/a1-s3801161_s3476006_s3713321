//
//  SearchViewCoordinator.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit



class SearchViewCoordinator: Coordinator, EventdFlow {
    func showDetails(){
        let vc = DetailsTableViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func backToEvent(_ newTask: Task) {
    
    }
    
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate()
        
        searchViewController.coordinator = self
        
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    
    func add_item() {
        let att = CreateTaskTableViewController.instantiate()
        att.coordinator = self
        // navigate to createTask page like event page
        
        navigationController?.pushViewController(att, animated: false)
    }
    
    
    // MARK: - Flow Methods
    
}
