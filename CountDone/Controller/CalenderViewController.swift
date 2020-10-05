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

        
        onSave?(selectedDate)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectedDate = date
     }


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


