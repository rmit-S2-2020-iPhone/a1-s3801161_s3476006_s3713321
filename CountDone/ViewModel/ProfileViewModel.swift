//
//  ProfileViewModel.swift
//  CountDone
//
//  Created by Changyu on 7/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
struct ProfileViewModel {
    var photo: String?
    var username: String?
    var email: String?
    var user_description: String?
    var profile: UserAccount
    
    //dependency injection
    init(profile: UserAccount){
        self.photo = profile.photo
        self.username = profile.username
        self.email = profile.email
        self.user_description = profile.user_description
        self.profile = profile
    }
}
