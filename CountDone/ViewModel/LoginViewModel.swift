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

    func loginVerification(email:String, password:String) -> Bool{
        //verification logic
        
        return false
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
