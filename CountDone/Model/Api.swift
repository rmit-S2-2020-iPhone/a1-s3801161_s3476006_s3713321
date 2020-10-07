//
//  Api.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/1.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import CoreData


class REST_Request
{
    
    private let session = URLSession.shared
    let base_url:String = "http://127.0.0.1:5000/"
    let paramUser: String = "users/"
    let paramEvent: String = "events/"
    let context = CoreDataStack.shared.context
    //to-do can make it to a closure
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserAccount.fetchRequest())
    let deleteEvents = NSBatchDeleteRequest(fetchRequest: Task.fetchRequest())
    
    func getUsers(withEmail:String)
    {
        let url = base_url + paramUser + withEmail
        
//        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: url)
        {
            let request = URLRequest(url: url)
            
            getData(request, element: "users")
        }
    }
    
    func getEvents(withId: Int){
        let url = base_url + paramEvent + String(withId)
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            getData(request, element: "events")
        }
        
    }
    
    private func getData(_ request: URLRequest, element: String)
    {
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if let error = downloadError
            {
                print(error)
            }
            else
            {
                var parsedResult: Any! = nil
                do
                {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                    print()
                }
                
                let results = parsedResult as! [[String:Any]]
//                print(results)
                if(element=="users"){
                    self.syncUsers(userList: results)
                }
                if(element=="events"){
                    self.syncEvents(eventList: results)
                }
            
                
            }
            
        })
        task.resume()
        
    }
    
    
    private func syncEvents(eventList: [[String:Any]]){
        if(!filterEvent()){
            for e in eventList{
                print(e)
                let event_id = e["id"]
                let event = Task(context: self.context)
                event.id = event_id as! Int64
                event.checked = false
                //to do parse true and false inapi to event
                event.taskTime =  Time(context: self.context)
                event.taskTime.startDate = NSDate()
                //to-do: parse time in event to taskTime
                event.taskDescrip = e["taskDescription"] as? String
                event.typeEmoji = "😀"
                event.title = e["title"] as! String
                //to-do type emoji parsing
                try! self.context.save()
            }
        }
    }
    
    private func filterEvent() -> Bool{
        let idRequest = Task.fetchRequest() as NSFetchRequest<Task>
        let num = 1
        let pred = NSPredicate(format:"id == '\(num)'")
        idRequest.predicate = pred
        let items = try! self.context.fetch(idRequest)
        if(items.count>0){
            return true
        }
        else{
            return false
        }
    }
    
    
    private func syncUsers(userList: [[String:Any]]){
        if(!filterId()){
            for user in userList{
                print(user)
                let id = user["id"] as! Int64
                print(id)
                let account = UserAccount(context: self.context)
                account.id = id
                account.email = user["email"] as? String
                account.username = user["username"] as? String
                account.user_description =  user["description"] as? String
                account.photo = user["photo"] as? String
                print(account)
                try! self.context.save()
                
            }
            
        }
    }
    
    public func emptyUsers(){
        try! self.context.execute(deleteRequest)
    }
    
    public func emptyEvents(){
        try! self.context.execute(deleteEvents)
    }
    
    public func getAccounts()->[UserAccount]{
        let users = try! self.context.fetch(UserAccount.fetchRequest())
        return users as! [UserAccount]
    }
    
    public func filterId() -> Bool {
        let idRequest = UserAccount.fetchRequest() as NSFetchRequest<UserAccount>
        let num = 1
        let pred = NSPredicate(format:"id == '\(num)'")
        idRequest.predicate = pred
        let items = try! self.context.fetch(idRequest)
        if(items.count>0){
            return true
        }
        else{
            return false
        }
    }
    
    
}
