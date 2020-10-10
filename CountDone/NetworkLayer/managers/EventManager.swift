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
               
                let parsedResult = try! JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                guard let results = parsedResult as? [[String:Any]]
                    else{
                        return
                }
                self.sync(eventList: results)
              
                
            case .failure(_):
               print("unable to request event")
            }
        }
    }
    
    func deleteEvent(id: Int){
        eventProvider.request(.deleteEvent(id: id)){ (result) in
            switch result{
            case .success(let response):
                print(response.statusCode)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func sync(eventList: [[String:Any]]) {
        
        for e in eventList{
            
            let event_id = e["id"] as! Int
            self.syncUser(event_id: event_id, userDict: e)
            
        }
    
    }
    
    public func updateEvent(id: Int, checked:Bool, taskDescription: String, title: String, typeEmoji: String, taskTime: Time){
        eventProvider.request(.updateEvent(id: id, checked: checked, taskDescription: taskDescription, title: title, typeEmoji: typeEmoji, taskTime: taskTime)){ (result) in
            switch result{
            case .success(let response):
                let parsedResult = try! JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                let result = parsedResult as! [String:Any]
                print(result)
                self.syncUser(event_id: id, userDict: result)
            case .failure(let error):
                print(error)
            }
        }
    }
    public func createEvent(checked:Bool, taskDescription: String, title: String, typeEmoji: String, taskTime: Time){
        eventProvider.request(.createEvent(checked: checked, taskDescription: taskDescription, title: title, typeEmoji: typeEmoji, taskTime: taskTime)){ (result) in
            switch result{
            case .success(let response):
                let parsedResult = try! JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                let result = parsedResult as! [String:Any]
                print(result)
                self.syncUser(event_id: result["id"] as! Int, userDict: result)
            case .failure(let error):
                print(error)
            }
        }
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
