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
        let manager = EventManager.manager
        manager.emptyEvents()
        manager.requestEvent()
        super.viewDidLoad()
//        setupUI()
    }
    
    var loginViewModel = LoginViewModel()

    
    @IBAction func login(_ sender: Any) {
        
        if loginViewModel.loginVerification(email: "email", password: "password"){
            coordinator?.coordinateToTabBar()
        }else{
            self.present(loginViewModel.verificationAlert(), animated: true, completion: nil)
        }
    }
        
    
    @IBAction func StraightIn(_ sender: Any) {
        coordinator?.coordinateToTabBar()
    }
    
    
    

    
}


