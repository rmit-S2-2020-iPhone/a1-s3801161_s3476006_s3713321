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
    
//    init(title: String, typeEmoji:String,description:String,time:Time,checked:Bool) {
//        self.title = title
//        self.typeEmoji = typeEmoji
//        self.taskDescrip = description
//        self.taskTime = time
//        self.checked = checked
//    }
    
    func toggleCheck(){
        checked = !checked
    }
}
