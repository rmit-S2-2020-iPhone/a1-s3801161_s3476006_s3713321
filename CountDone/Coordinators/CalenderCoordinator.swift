//
//  CalenderCoordinator.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/23.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit

protocol CalenderFlow: class {

}

class CalenderCoordinator: Coordinator, CalenderFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
       let vc = CalenderViewController.instantiate()
       vc.coordinator = self
       navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
    // MARK: - Flow Methods
    
}
