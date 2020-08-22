//
//  SearchCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

protocol SearchFlow: class {
}

class SearchCoordinator: Coordinator, SearchFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate()
        
        searchViewController.coordinator = self
        
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    
    // cy: can be deleted later
}
