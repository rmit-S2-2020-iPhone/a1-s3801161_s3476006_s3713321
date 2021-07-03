//
//  Task+CoreDataProperties.swift
//  CountDone
//
//  Created by Fanwei Wang on 12/9/20.
//  Copyright © 2020 G33. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: Int64
    @NSManaged public var checked: Bool
    @NSManaged public var taskDescrip: String?
    @NSManaged public var title: String
    @NSManaged public var typeEmoji: String?
    @NSManaged public var taskTime: Time

}
