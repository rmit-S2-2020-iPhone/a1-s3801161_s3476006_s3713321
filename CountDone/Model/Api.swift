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


class REST_Request
{
    
    private let session = URLSession.shared
    private let base_url:String = "http://127.0.0.1:5000/"
    private let paramUser: String = "users/"
    
    
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
                
                let result = parsedResult as! [[String:Any]]
                
                print(result)
                
            }
            
        })
        task.resume()
        
    }
    
    
}
