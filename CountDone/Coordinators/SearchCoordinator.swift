//
//  SearchViewCoordinator.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

<<<<<<< HEAD


class SearchViewCoordinator: Coordinator, EventdFlow {
    func backToEvent(_ newTask: Task) {
    
    }
    
=======
protocol SearchViewFlow: class {
    func add_this_task()
}

class SearchViewCoordinator: Coordinator, SearchViewFlow {
>>>>>>> cy
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate()
        
        searchViewController.coordinator = self
        
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    
<<<<<<< HEAD
    func add_item() {
        let att = CreateTaskViewController.instantiate()
        att.coordinator = self
=======
    func add_this_task() {
        let att = CreateTaskViewController.instantiate()
        att.coordinator = self as? SearchViewFlow as! EventdFlow
>>>>>>> cy
        // navigate to createTask page like event page
        
        navigationController?.pushViewController(att, animated: false)
    }
    
    
    // MARK: - Flow Methods
    
}
