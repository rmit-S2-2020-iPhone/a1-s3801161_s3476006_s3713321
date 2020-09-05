//
//   Time.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/9/2.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation

struct Time{
    var startDateComponent:DateComponents
    var endDateCompoment: DateComponents?
    let calender = Calendar.current
    
    /**
     initialize a time class for the task.
     
     - Parameters:
        -year: the year of start time
        -month: the month of start time
        -day: the day of start time
        -hour: the hour of start time
        -min: the min of start time
        -end_year: the year of end time
        -end_month: the month of end time
        -end_day: the day of end time
        -end_hour: the hour of end time
        -end_min: the min of end time
     
     */
<<<<<<< HEAD
=======
    
    init(startDateComponent:DateComponents) {
        self.startDateComponent = startDateComponent
    }
>>>>>>> xd
    init(year: Int, month:Int, day: Int, hour: Int, min: Int){
        self.startDateComponent = DateComponents(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute:min
        )
    }
    
    init(year: Int, month:Int, day: Int, hour: Int, min: Int,end_year: Int, end_month:Int, end_day: Int, end_hour: Int, end_min: Int) {
        self.startDateComponent = DateComponents(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute:min)
        self.endDateCompoment = DateComponents(
            year: end_year,
            month: end_month,
            day: end_day,
            hour: end_hour,
            minute:end_min
        )
        
    }
    /**
     calculate the time interval from this time to another time.
     
     - returns:
         -day: the date interval from last task to today(if before today return a positive value, else return a negative value)
     
     */
    func calculateLastInterval() -> Double{
        let today = Date()
        let eventDate = calender.date(from: self.startDateComponent)
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
