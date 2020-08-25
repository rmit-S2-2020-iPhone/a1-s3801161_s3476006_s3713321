//
//  ToDolistItem.swift
//  CountDone
//
//  Created by Fanwei Wang on 7/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation

class Task{
    var title = ""
    var typeEmoji = ""
    var description = ""
    var checked  = true
    var date:Date?
    
    init(title: String, typeEmoji:String,description:String,date:Date,checked:Bool) {
        self.title = title
        self.typeEmoji = typeEmoji
        self.description = description
        self.date = date
        self.checked = checked
    }
    
    func toggleCheck(){
        checked = !checked
    }
}
