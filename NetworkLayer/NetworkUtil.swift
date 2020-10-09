//
//  NetworkUtil.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/10/9.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit


enum dateFormatError: Error, Equatable {
    case runtimeError(String)
}

public class NetWorkUtil{
    // asingleton class that work for the network services!
    public static let util = NetWorkUtil()
    private let delegate = (UIApplication.shared.delegate as! AppDelegate)
    private let formatter = DateFormatter()
    
    init(){
        self.formatter.dateFormat = "MM/dd/yyyy, HH:mm:ss"
    }
    
    func readCurrentId() -> Int {
        return delegate.currentId
    }
    
    func dateToString(date:NSDate) -> String{
        
        let dateString = formatter.string(from: date as Date)
        return dateString
    }
    
    func StringToDate(dateString:String) throws -> NSDate{
        guard let date = formatter.date(from: dateString)
        else{
            throw dateFormatError.runtimeError("fail to format string")
        }
        return date as NSDate
    }
    
    
    
   
}
