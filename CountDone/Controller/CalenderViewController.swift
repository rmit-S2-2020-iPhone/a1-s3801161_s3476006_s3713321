//
//  CalenderViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/23.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit
import FSCalendar
import CoreData


class CalenderViewController: UIViewController, Storyboarded, FSCalendarDelegate,UIWebViewDelegate {
    var coordinator: CalenderFlow?
    var dateArray: [String] = []
    var dateCollect = [Date]()
    
    var selectedDate = Date()
    var onSave: ((_ date: Date) -> ())?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var calendar:FSCalendar!
    @IBOutlet weak var calendarView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTask()
        calendar.delegate = self
        
        calendar.appearance.eventDefaultColor = UIColor.green
        calendar.appearance.eventSelectionColor = UIColor.green
        
        
        calendarView.layer.cornerRadius = 20
        calendarView.layer.masksToBounds = true
        calendar.reloadData()
        
        
    }
    

    
    func loadTask(){
        //Request
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        //Fetch
        do{
            let tasks = try CoreDataStack.shared.context.fetch(request)

            for task in tasks{
                if !dateCollect.contains(task.taskTime.startDate as Date){
                    dateCollect.append(task.taskTime.startDate as Date)
                }
            }
            
            for date in dateCollect{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: date)
                dateArray.append(dateString)
            }

        } catch{}
    }

    @IBAction func save(_ sender: UIButton) {
//        var passedDate = Date()
//        let ca  = Calendar.current
//        passedDate = ca.date(byAdding: .day, value: -2, to: passedDate)!
//        print(passedDate)
        
        onSave?(selectedDate)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//         let dateFormatter3 = DateFormatter()
//         dateFormatter3.dateFormat = "yyyy-MM-dd"
//         let dateString = dateFormatter3.string(from: date)
//         if self.dateArray.contains(dateString){
//             text.text = "Today you have an event"
//             self.calender.reloadData()
//         }else{
//             text.text = "you don't have work for today!!"
//         }
        self.selectedDate = date
     }

//
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
////        let dateFormatter3 = DateFormatter()
////        dateFormatter3.dateFormat = "yyyy-MM-dd"
////        let dateString = dateFormatter3.string(from: date)
////
////        //display events as dots
////        cell.eventIndicator.isHidden = false
////        cell.eventIndicator.color = UIColor.green
////
////
////        if self.dateArray.contains(dateString){
////            cell.subtitle = "1"
////        }else{
////            cell.subtitle = " "
////
////        }
//
////        if self.dateCollect.contains(){
////            cell.eventIndicator.numberOfEvents = 1
////        }
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

extension CalenderViewController: FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter3.string(from: date)
        
        if dateArray.contains(dateString){
            return 1
        }
        return 0
    }
}


