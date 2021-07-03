//
//  CreateTaskViewModel.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/11.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit

class CreateTaskViewModel{
    var task:Task?
    var editMode:Bool
    var datePicker: UIDatePicker
    let context = CoreDataStack.shared.context
    var dateTimeText:String
    var vc: CreateTaskTableViewController?
    
    fileprivate static func updateTimeText(date:Date) -> String{
        let currentDateTimeFormatter = DateFormatter()
        currentDateTimeFormatter.dateFormat = "HH:mm E, d MMM"
        return currentDateTimeFormatter.string(from: date)
    }
    
   
    
    init(editMode:Bool){
        self.editMode = editMode
        self.datePicker = UIDatePicker()
        if(!editMode){
            let currentDateTime = Date()
            self.dateTimeText = CreateTaskViewModel.updateTimeText(date: currentDateTime)
            
        }
        else{
            self.dateTimeText = "lol"
        }
       
    }
    
    func updateTime(){
        dateTimeText = CreateTaskViewModel.updateTimeText(date: datePicker.date)
    }
    
   
    
    func done(title:String, typeEmoji:String,taskDescrip:String,time:Time) -> String?{
        time.startDate = datePicker.date as NSDate
        let tagName = TagList.getter.getTag(tagEmoji: typeEmoji)
        let emoji = tagName.tagName
        if(!editMode){
            let code = EventManager.manager.createEvent(checked:false, taskDescription: taskDescrip, title: title, typeEmoji: emoji, taskTime: time)
            if(code == 400){
                let event = Task(context: self.context)
                event.id = 0 as Int64
                event.title = title
                event.checked = false
                event.taskDescrip = taskDescrip
                event.taskTime = time
                event.typeEmoji = emoji
            do{
                try context.save()
                return "uploaded"
            }
                
            catch{
                print(error)
                    }
                }
            
            return String(code)
            }
        else{
            task?.title = title
            task?.taskDescrip = taskDescrip
            task?.taskTime = time
            task?.typeEmoji = emoji
            try! context.save()
            EventManager.manager.updateEvent(task: task!)
            return String("200")
        }
    }
    }
    
    

