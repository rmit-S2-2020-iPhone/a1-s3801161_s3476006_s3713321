//
//  TaskViewModelTest.swift
//  CountDoneTests
//
//  Created by Fanwei Wang on 11/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import XCTest
@testable import CountDone

class TaskViewModelTest: XCTestCase {

    var taskViewModel: TaskViewModel!
    
    let formatter = DateFormatter()
    var someDateTime:Date?
    var dateTime1:Date?
    var dateTime2:Date?
    override func setUp() {
        taskViewModel = TaskViewModel()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        someDateTime = formatter.date(from: "2016/10/08 22:31")

    }

    override func tearDown() {
        taskViewModel = nil
        someDateTime = nil

    }

    func testDateFrom_Dateto_Setting() {
        
        taskViewModel.selectedDate = someDateTime!
        
        let datefrom = formatter.string(from: taskViewModel.dateFrom)
        let dateTo = formatter.string(from: taskViewModel.dateTo!)
        
        XCTAssertEqual(datefrom, "2016/10/08 00:00")
        XCTAssertEqual(dateTo, "2016/10/09 00:00")
        
    }
    
    



}
