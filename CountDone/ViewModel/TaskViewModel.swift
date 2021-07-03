//
//  TaskViewModel.swift
//  CountDone
//
//  Created by Fanwei Wang on 3/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import CoreData

enum TaskLoadIn{
    case main
    case search
}

struct TaskViewModel {
    
    var count: Int {
        return tasks.count
    }
    
    var tasks = [Task]()
    
    var selectedDate = Date(){
        didSet{
            dateFrom = calendar.startOfDay(for: selectedDate)
            dateTo = calendar.date(byAdding: .day, value: 1,to: dateFrom)
        }
    }
    var calendar = Calendar.current
    lazy var dateFrom = calendar.startOfDay(for: selectedDate)
    lazy var dateTo = calendar.date(byAdding: .day, value: 1,to: dateFrom)
    
    mutating func reloadData(in view: TaskLoadIn){
        //Request
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        //set sort
        let sortByDate = NSSortDescriptor(key: "taskTime.startDate", ascending: true)
        
        switch view {
        case .main:
            let sortByCheck = NSSortDescriptor(key: "checked", ascending: true)
            request.sortDescriptors = [sortByCheck,sortByDate]
            //set filter
            let fromPredicate = NSPredicate(format: "taskTime.startDate >= %@", dateFrom as NSDate)
            let toPredicate = NSPredicate(format: "taskTime.startDate < %@", dateTo! as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            request.predicate = datePredicate
    
        case .search:
            request.sortDescriptors = [sortByDate]
        }
        //Fetch
        do{
            let tasks = try CoreDataStack.shared.context.fetch(request)
            self.tasks = tasks
        } catch{}
    }
    
    func deleteTask(at index: Int){
        let task = tasks[index]
        EventManager.manager.deleteEvent(id: Int(task.id) )
        CoreDataStack.shared.delete(task)
    }
    
    func getTaskFor(_ index: Int ) -> Task{
        return tasks[index]
    }
    
    func getDateTimeFor(_ index: Int) -> NSDate{
        return tasks[index].taskTime.startDate
    }

    func getCheckedFor(_ index: Int) -> Bool{
        return tasks[index].checked
    }
    
    
}

