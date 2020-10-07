//
//  utilities.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/6.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit

//this is utility class for our project, it is for code reuse
class utilities{
    static let util = utilities()
    
    func get_image(address:String) -> UIImage? {
        var image:UIImage? = nil
        //TBD1: use a default image for the none-image or can't find image situation
        let imageUrl = URL(string: address)!
        let data = try? Data(contentsOf: imageUrl)
        
        if let imageData = data {
            image = UIImage(data: imageData)
        }
        
        return image
        //TBD2: after finishing the TBD1, remove TBD1
       
    }
}
