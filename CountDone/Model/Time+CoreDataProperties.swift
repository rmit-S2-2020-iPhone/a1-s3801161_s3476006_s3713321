//
//  Time+CoreDataProperties.swift
//  CountDone
//
//  Created by Fanwei Wang on 12/9/20.
//  Copyright © 2020 G33. All rights reserved.
//
//

import Foundation
import CoreData


extension Time {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Time> {
        return NSFetchRequest<Time>(entityName: "Time")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var startDate: NSDate
    @NSManaged public var task: Task?

}
