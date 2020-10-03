//
//  TaskViewModel.swift
//  CountDone
//
//  Created by Fanwei Wang on 3/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
struct TaskViewModel {
    var checked: Bool
    var taskDescrip: String?
    var title: String
    var typeEmoji: String?
    var taskTime: Time
    var task: Task
    
    
    //dependency injection
    init(task: Task){
        self.title = task.title
        self.taskDescrip = task.taskDescrip
        self.typeEmoji = task.typeEmoji
        self.taskTime = task.taskTime
        self.checked = task.checked
        self.task = task
    }
}
