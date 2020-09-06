//
//  CalenderViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/23.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import FSCalendar

class CalenderViewController: UIViewController, Storyboarded, FSCalendarDelegate,UIWebViewDelegate {
    var coordinator: CalenderFlow?
    var dateArray: [String] = ["2020-08-08","2020-08-23"]
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet var calender:FSCalendar!
   
    @IBOutlet weak var Description: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        calender.delegate = self
        calender.appearance.eventDefaultColor = UIColor.blue
        calender.appearance.eventSelectionColor = UIColor.red
        
        // Do any additional setup after loading the view.
    }
    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter3.string(from: date)
//        if self.dateArray.contains(dateString){
//            text.text = "Today you have an event"
//
//        }else{
//            text.text = "you don't have work for today!!"
//        }
//        self.calender.reloadData()
//
//    }
    
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat = "yyyy-MM-dd"
//        let dateString = dateFormatter3.string(from: date)
//        
//        //display events as dots
//        cell.eventIndicator.isHidden = false
//        //cell.eventIndicator.color = UIColor.green
//        
//        
//        if self.dateArray.contains(dateString){
//            cell.eventIndicator.numberOfEvents = 1
//        }
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

