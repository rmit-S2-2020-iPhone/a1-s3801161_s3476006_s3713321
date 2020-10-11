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
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passWordField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
    
        
        super.viewDidLoad()
//        defaults.set(1, forKey: "userId")
        let id = defaults.integer(forKey: "userId")
        print(id)
        if(id != 0){
            NetWorkUtil.util.id = id
            let manager = EventManager.manager
            manager.requestEvent()
            toTabBar()
            
        }
//        setupUI()
    }
    
    var loginViewModel = LoginViewModel()

    
    @IBAction func login(_ sender: Any) {
        
        guard let email = userNameField.text else {
            self.present(loginViewModel.verificationAlert(), animated: true, completion: nil)
            return
        }
        
        guard let password = passWordField.text else {
            self.present(loginViewModel.verificationAlert(), animated: true, completion: nil)
            return
        }
        
        print(email)
        print(password)
        
        if loginViewModel.loginVerification(email:email, password: password){
            
            coordinator?.coordinateToTabBar()
        }else{
            self.present(loginViewModel.verificationAlert(), animated: true, completion: nil)
        }
    }
    
    func toTabBar(){
         coordinator?.coordinateToTabBar()
    }
        
    
    @IBAction func StraightIn(_ sender: Any) {
        coordinator?.coordinateToTabBar()
    }
    
    
    

    
}


