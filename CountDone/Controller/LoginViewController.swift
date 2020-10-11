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
    let manager = EventManager.manager
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passWordField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
    
        
        super.viewDidLoad()
//        defaults.set(1, forKey: "userId")
        let id = defaults.integer(forKey: "userId")
        userNameField.text = "duanxinhuan@163.com"
        passWordField.text = "123a"
        passWordField.isSecureTextEntry = true
        if(id != 0){
            NetWorkUtil.util.id = id
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
        
        
        if loginViewModel.loginVerification(email:email, password: password){
            manager.requestEvent()
            let alert = loginViewModel.firstLoginAlert()
            self.navigationController?.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
                self.toTabBar()
            }
            
        }else{
            self.present(loginViewModel.verificationAlert(), animated: true, completion: nil)
        }
    }
    
    func toTabBar(){
         coordinator?.coordinateToTabBar()
    }
        
    
   
    @IBAction func showPassWord(_ sender: Any) {
        let aler = loginViewModel.erificationAlert()
        self.navigationController?.present(aler, animated: true, completion: nil)
    }
    
    
    

    
}


