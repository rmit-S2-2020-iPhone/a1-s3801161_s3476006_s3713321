//
//  ToDolistItem.swift
//  CountDone
//
//  Created by Fanwei Wang on 7/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
enum type{
    case sports
}


class Task{
    var list = ["🏃",]
    var title = ""
    var typeEmoji = ""
    var description = ""
    var date = ""
    var time:Time
    var checked  = true
    
    init(title: String, typeEmoji:String,description:String,time:Time,checked:Bool) {
        self.title = title
        self.typeEmoji = typeEmoji
        self.description = description
        self.time = time
        self.checked = checked
    }
    
    func toggleCheck(){
        checked = !checked
    }
}
