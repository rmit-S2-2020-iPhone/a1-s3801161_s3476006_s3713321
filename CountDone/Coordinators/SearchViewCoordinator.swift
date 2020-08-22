//
//  SearchViewCoordinator.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

protocol SearchViewFlow: class {
    func add_this_task()
}

class SearchViewCoordinator: Coordinator, SearchViewFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController.instantiate()
        
        viewController.coordinator = self
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func add_this_task() {
        let att = CreateTaskViewController.instantiate()
        att.coordinator = self as? EventdFlow
        // navigate to createTask page like event page
        
        navigationController?.pushViewController(att, animated: false)
    }
    
    
    // MARK: - Flow Methods
    
}
