//
//  ProfileData.swift
//  CountDone
//
//  Created by Changyu on 3/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import CoreData


extension Profile {
    
    @nonobjc public class func profileFetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }
    
    @NSManaged public var studentPhoto: String?
    @NSManaged public var studentName: String?
    @NSManaged public var studentEmail: String?
    @NSManaged public var studentIntroduction: String?
    
}

