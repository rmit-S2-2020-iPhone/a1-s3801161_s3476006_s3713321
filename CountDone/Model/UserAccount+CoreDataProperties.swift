//
//  UserAccount+CoreDataProperties.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/1.
//  Copyright © 2020 G33. All rights reserved.
//
//

import Foundation
import CoreData


extension UserAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAccount> {
        return NSFetchRequest<UserAccount>(entityName: "UserAccount")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var photo: String?
    @NSManaged public var user_description: String?
    @NSManaged public var username: String?

}
