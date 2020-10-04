//
//  ProfileCoordinator.swift
//  CountDone
//
//  Created by Changyu on 2/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import Foundation

protocol ProfileFlow: class {
    
}

class ProfileCoordinator: Coordinator, ProfileFlow{
    
    var parentCoordinator: TabBarCoordinator?
    
    var currentCell: TaskTableViewCell?
    
    var profileViewController: ProfileViewController?
    
    var controllerDic: [String: UIViewController] = [:]
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        profileViewController = ProfileViewController.instantiate()
        
        profileViewController!.coordinator = self
        
        controllerDic = ["ProfileViewController":profileViewController!]
        
        navigationController?.pushViewController(profileViewController!, animated: false)
    }
    
}
