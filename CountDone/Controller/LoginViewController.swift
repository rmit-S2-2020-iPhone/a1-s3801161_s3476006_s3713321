//
//  StartViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,Storyboarded {
    var coordinator: StartFlow?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
    }
    
//    // MARK: - Actions
    @IBAction func login(_ sender: Any) {
        coordinator?.coordinateToTabBar()
    }
    
    // MARK: - Properties
    

    
    

    
}


