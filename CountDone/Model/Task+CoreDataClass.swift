//
//  Task+CoreDataClass.swift
//  CountDone
//
//  Created by Fanwei Wang on 11/9/20.
//  Copyright © 2020 G33. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    func toggleCheck(){
        checked = !checked
    }
}
