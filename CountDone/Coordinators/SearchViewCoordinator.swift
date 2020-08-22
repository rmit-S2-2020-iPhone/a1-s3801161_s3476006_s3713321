//
//  SearchViewCoordinator.swift
//  CountDone
//
//  Created by Changyu on 23/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

protocol SearchViewFlow: class {
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
    
    // MARK: - Flow Methods
    
}
