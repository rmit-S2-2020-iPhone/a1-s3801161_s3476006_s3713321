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
    private let base_url:String = "http://127.0.0.1:5000/"
    private let paramUser: String = "users/"
    let context = CoreDataStack.shared.context
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserAccount.fetchRequest())
    
    func getUsers(withEmail:String)
    {
        let url = base_url + paramUser + withEmail
        
//        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: url)
        {
            let request = URLRequest(url: url)
            
            getData(request, element: "results")
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
                self.syncUsers(userList: results)
            
                
            }
            
        })
        task.resume()
        
    }
    
    
    private func syncUsers(userList: [[String:Any]]){
        let list = getAccounts()
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
    
    public func emptyUsers(){
        try! self.context.execute(deleteRequest)
    }
    
    public func getAccounts()->[UserAccount]{
        let users = try! self.context.fetch(UserAccount.fetchRequest())
        return users as! [UserAccount]
    }
    
    public func filterId() -> Bool {
        let idRequest = UserAccount.fetchRequest() as NSFetchRequest<UserAccount>
        let pred = NSPredicate(format:"id == '1'")
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
