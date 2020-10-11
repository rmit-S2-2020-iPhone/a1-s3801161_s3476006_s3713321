//
//  ProfileCoordinator.swift
//  CountDone
//
//  Created by Changyu on 4/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import Foundation

protocol ProfileFlow: class {
    var profileCurrentCell: ProfileViewCell?{get set}
    var parentCoordinator:TabBarCoordinator?{get set}
}

class ProfileCoordinator: Coordinator, ProfileFlow{
    
    var parentCoordinator: TabBarCoordinator?
    
    var profileCurrentCell: ProfileViewCell?
    
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
