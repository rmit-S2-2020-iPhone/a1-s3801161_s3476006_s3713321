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
    
    let userIdDict = [
        "duanxinhuan@163.com": 1,
        "lucas@xyz.com": 2,
        "cy@pp.com": 3
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
        
        userDefault.set(userIdDict[email], forKey: "userId")
        NetWorkUtil.util.id = userDefault.integer(forKey: "userId")
        return true
    }
    
    func verificationAlert() -> UIAlertController{
        let alert = UIAlertController(title: "Verification Failed", message: "Your E-mail address or password is incorrect.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: {
            ACTION in
        })
        alert.addAction(ok)
        return alert
    }
    
    func erificationAlert() -> UIAlertController{
        let message = """

This alert box is only for the assgnment submission,it is designed for marker to test application and try other user accounts, the register function is closed in the early version

test accounts:

email: lucas@xyz.com
password: 321b
email: cy@pp.com
password: 456c

"""
        let alert = UIAlertController(title: "password message", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: {
            ACTION in
        })
        alert.addAction(ok)
        return alert
    }
    
    func firstLoginAlert() -> UIAlertController{
        let alert = UIAlertController(title: "", message: "This is your first login after log out we need several seconds to fetch your data from api", preferredStyle: .alert)
        
       
        
        return alert
    }
    
    
}
