//
//  Time+CoreDataClass.swift
//  CountDone
//
//  Created by Fanwei Wang on 11/9/20.
//  Copyright © 2020 G33. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Time)
public class Time: NSManagedObject {
    
    var startDateComponent:DateComponents?
    var endDateCompoment: DateComponents?
    let calender = Calendar.current
    
    // calculate the time interval
    func calculateLastInterval() -> Double{
        let today = Date()
        let eventDate = calender.date(from: self.startDateComponent!)
        var interval: DateInterval
        var day:Double
        if(today>eventDate!){
            interval =  DateInterval(start: eventDate! ,end: today )
            day = interval.duration/60/60/240
        }
            
        else{
            interval =  DateInterval(start: today ,end: eventDate! )
            day = -interval.duration/60/60/240
        }
        
        return day
    }
}
