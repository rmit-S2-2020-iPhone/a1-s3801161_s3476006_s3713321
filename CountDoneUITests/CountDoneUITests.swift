//
//  CountDoneUITests.swift
//  CountDoneUITests
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import XCTest

class CountDoneUITests: XCTestCase {

    override func setUp() {
       
        continueAfterFailure = false
        let de = UserDefaults.standard
        de.set(0, forKey: "userId")

        XCUIApplication().launch()

    }
    

    override func tearDown() {
        
    }
    
    func test_Login(){
        
    }

    func testMainView_ChangeDateToDisplay(){
            
            let app = XCUIApplication()
            let date = Date()
        
            let format = DateFormatter()
            format.dateFormat = "d MMM"
            let buttondate = format.string(from: date)
            format.dateFormat = "d"
            var buttondate2 = (Int)(format.string(from: date))!
            buttondate2 -= 1
        
            let todayNavigationBar = app.navigationBars["Today"]
            XCTAssert(todayNavigationBar.exists)
            todayNavigationBar.buttons[buttondate].tap()
            app.collectionViews.staticTexts["\(buttondate2)"].tap()
            app.buttons["Save"].tap()
            let yesterdayNivigationBar = app.navigationBars["Yesterday"].otherElements["Yesterday"]
            XCTAssert(yesterdayNivigationBar.exists)
        
    }
    
    func testMainView_NewTaskWithoutTitle(){
        
        let app = XCUIApplication()
        app.buttons["add"].tap()
        let doneButton = app.navigationBars["Create task"].buttons["Done"]
        XCTAssertFalse(doneButton.isEnabled)
        
    }
    
    func testMainView_NewTaskWithTitle(){
        
        let app = XCUIApplication()
        
        app.buttons["add"].tap()
        let titleTextField = app.tables/*@START_MENU_TOKEN@*/.textFields["Title"]/*[[".cells.textFields[\"Title\"]",".textFields[\"Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        titleTextField.tap()
        titleTextField.typeText("xx")
        
        let doneButton = app.navigationBars["Create task"].buttons["Done"]
        XCTAssertTrue(doneButton.isEnabled)
    }
    
    
    func testMainView_CreateAndDeleteTask(){
        
        let app = XCUIApplication()
        let newTaskTitle = "NewTaskTest"
        let tablesQuery = app.tables
        
        app.buttons["add"].tap()
        
        let titleTextField = tablesQuery.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText(newTaskTitle)
        
        
        app.navigationBars["Create task"].buttons["Done"].tap()
        let newTaskCell = tablesQuery.staticTexts[newTaskTitle]

        
        XCTAssertTrue(newTaskCell.exists)
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["NewTaskTest"]/*[[".cells.staticTexts[\"NewTaskTest\"]",".staticTexts[\"NewTaskTest\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        let tables = app.tables
        
        
        XCTAssertTrue(tables.count == 1)
        XCTAssertFalse(newTaskCell.exists)
        
    }
    
    
    
    
    
}
