//
//  ToDolistItem.swift
//  CountDone
//
//  Created by Fanwei Wang on 7/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation

class ToDolistItem{
    var title = ""
    var typeEmoji = ""
    var description = ""
    var date = ""
    var time = ""
    var checked  = false
    
    init(title: String, typeEmoji:String,description:String,date:String,time:String,checked:Bool) {
        self.title = title
        self.typeEmoji = typeEmoji
        self.description = description
        self.date = date
        self.time = time
        self.checked = checked
    }
    
    func toggleCheck(){
        checked = !checked
    }
}
