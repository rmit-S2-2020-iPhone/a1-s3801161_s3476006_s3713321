//
//  EventManager.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/9.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import CoreData
import Moya

enum apiError: Error, Equatable{
    case updateError(String)
    // set id to negative
    case createError(String)
    //set id to 0
    case deleteError(String)
    // set title to [deleted]
    case getError(String)
}

class EventManager{
    let context = CoreDataStack.shared.context
    var eventProvider = MoyaProvider<TaskService>()
    public static let manager = EventManager()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserAccount.fetchRequest())
    let deleteEvents = NSBatchDeleteRequest(fetchRequest: Task.fetchRequest())
    
    func requestEvent() {
        eventProvider.request(.readEvents(userId: NetWorkUtil.util.readCurrentId()))
        { (result) in
            switch result{
            case .success(let response):
                
                if(response.statusCode == 500){
                    self.requestEvent()
                }
                else{
                    let parsedResult = try! JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                    guard let results = parsedResult as? [[String:Any]]
                        else{
                            return
                    }
                    self.sync(eventList: results)
                    
                }
              
                
            case .failure(_):
               print("you are offline")
            }
        }
    }
    
    func deleteEvent(id: Int){
        eventProvider.request(.deleteEvent(id: id)){ (result) in
            switch result{
            case .success(let response):
                if(response.statusCode != 204){
                    self.deleteEvent(id: id)
                }
                else{
                    print(response.statusCode)
                    
                }
            case .failure(_):
                print("you are offline")
            }
        }
    }
    private func sync(eventList: [[String:Any]]) {
        
        for e in eventList{
            
            let event_id = e["id"] as! Int
            self.syncUser(event_id: event_id, userDict: e)
            
        }
    
    }
    
    public func updateEvent(task: Task){
        task.id = Int64(-2)
        try! self.context.save()
        eventProvider.request(.updateEvent(id: Int(task.id), checked: task.checked, taskDescription: task.taskDescrip!, title: task.title, typeEmoji: task.typeEmoji!, taskTime: task.taskTime)){ (result) in
            switch result{
            case .success(let response):
                if(response.statusCode == 500){
                    self.updateEvent(task: task)
                }
                else{
                    let parsedResult = try! JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                    let result = parsedResult as! [String:Any]
                    let id = result["id"] as! Int
                    task.id = Int64(id)
                    
                }
//                self.quickSync(event_id: id, userDict: result)
            case .failure(_):
                print("you are off line")
            }
        }
    }
    public func createEvent(checked:Bool, taskDescription: String, title: String, typeEmoji: String, taskTime: Time) -> Int{
        var statisCode = 0
        
        let task = Task(context: self.context)
        // set it to neagtive 1 before api give back the id
        task.id = Int64(-1)
        task.checked = checked
        task.taskDescrip = taskDescription
        task.title = title
        task.typeEmoji = typeEmoji
        task.taskTime = taskTime
        try! self.context.save()
        eventProvider.request(.createEvent(checked: checked, taskDescription: taskDescription, title: title, typeEmoji: typeEmoji, taskTime: taskTime)){ (result) in
            switch result{
            case .success(let response):
                if(response.statusCode == 500){
                    let code = self.createEvent(checked:checked, taskDescription: taskDescription, title: title, typeEmoji: typeEmoji, taskTime: taskTime)
                    statisCode = code
                }
                else if(response.statusCode < 300){
                    let parsedResult = try! JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                    let result = parsedResult as! [String:Any]
                    print(result)
                    
                    self.quickSync(event_id: result["id"] as! Int, task: task)
                    statisCode = 200
                    
                }
                else{
                    statisCode = 400
                }
            case .failure(_):
                print("your are off line")
                statisCode = 400
            }
        }
        return statisCode
    }
    private func syncUser(event_id: Int, userDict: [String:Any]){
        var event:Task
        if (getEventById(id: event_id) != nil){
            event = getEventById(id: event_id)!
        }
        else{
            event = Task(context: self.context)
        }
        event.id = Int64(event_id as Int)
        event.checked = userDict["checked"] as! Bool
        //to do parse true and false inapi to event
        event.taskTime =  Time(context: self.context)
        let timeString = userDict["startDatetime"] as! String
        event.taskTime.startDate = try! NetWorkUtil.util.StringToDate(dateString: timeString)
        //to-do: parse time in event to taskTime
        event.taskDescrip = userDict["taskDescription"] as? String
        event.typeEmoji = userDict["typeEmoji"] as? String
        event.title = userDict["title"] as! String
        //to-do type emoji parsing
        try! self.context.save()
    }
    
    private func quickSync(event_id: Int, task:Task){
        task.id = Int64(event_id as Int)
        try! self.context.save()
    }
    
  
    
    private func getEventById(id : Int) -> Task?{
        let idRequest = Task.fetchRequest() as NSFetchRequest<Task>
        
        let pred = NSPredicate(format:"id == '\(id)'")
        idRequest.predicate = pred
        let items = try! self.context.fetch(idRequest)
        if(items.count > 0){
            return items[0]
        }
        return nil
    }
    
    public func emptyEvents(){
        try! self.context.execute(deleteEvents)
    }
    
    
}
