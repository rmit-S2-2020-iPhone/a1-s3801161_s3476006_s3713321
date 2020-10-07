//
//  Profile.swift
//  CountDone
//
//  Created by Changyu on 7/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation

class _UserAccount{
    var photo = "https://www.nationalgeographic.com/content/dam/animals/thumbs/rights-exempt/mammals/d/domestic-dog_thumb.ngsversion.1546554600360.adapt.1900.1.jpg"
    var name = "GouGe"
    var email = "gouge@example.org"
    var user_description = "handsome"
    
    init(photo: String, name: String, email: String, user_description: String) {
        self.photo = photo
        self.name = name
        self.email = email
        self.user_description = user_description
    }
}
