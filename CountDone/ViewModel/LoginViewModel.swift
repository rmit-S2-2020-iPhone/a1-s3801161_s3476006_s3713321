//
//  LoginViewModel.swift
//  CountDone
//
//  Created by Fanwei Wang on 10/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit

class LoginViewModel{
    
    let passWordDict = [
        "duanxinhuan@163.com": "123a",
        "lucas@xyz.com": "321b",
        "cy@pp.com": "456c"
    ]
    
    let userDefault = UserDefaults.standard

    func loginVerification(email:String, password:String) -> Bool{
        //verification logic
        
        guard let pass = passWordDict[email]
            else{
                return false
       }
        if pass != password{
            print(pass)
            return false
        }
        
        
        
        return true
    }
    
    func verificationAlert() -> UIAlertController{
        let alert = UIAlertController(title: "Verification Failed", message: "Your E-mail address or password is incorrect.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: {
            ACTION in
            print("OK pressed")
        })
        alert.addAction(ok)
        return alert
    }
    
    
}
