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
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainView_ChangeDateToDisplay(){
            
            let app = XCUIApplication()
            app.buttons["Get Stared"].tap()
            
            let todayNavigationBar = app.navigationBars["Today"]
            XCTAssert(todayNavigationBar.exists)
            todayNavigationBar.buttons["9 Oct"].tap()
            app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["8"]/*[[".cells.staticTexts[\"8\"]",".staticTexts[\"8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.buttons["Save"].tap()
            let yesterdayNivigationBar = app.navigationBars["Yesterday"].otherElements["Yesterday"]
            XCTAssert(yesterdayNivigationBar.exists)
        
    }
    
    func testMainView_NewTaskWithoutTitle(){
        
        let app = XCUIApplication()
        app.buttons["Get Stared"].tap()
        app.buttons["add"].tap()
        let doneButton = app.navigationBars["Create task"].buttons["Done"]
        XCTAssertFalse(doneButton.isEnabled)
        
    }
    
    func testMainView_NewTaskWithTitle(){
        
        let app = XCUIApplication()
        app.buttons["Get Stared"].tap()
        app.buttons["add"].tap()
        let titleTextField = app.tables/*@START_MENU_TOKEN@*/.textFields["Title"]/*[[".cells.textFields[\"Title\"]",".textFields[\"Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        titleTextField.typeText("xx")
        
        let doneButton = app.navigationBars["Create task"].buttons["Done"]
        XCTAssertTrue(doneButton.isEnabled)
    }
    
    
    func testMainView_CreateAndDeleteTask(){
//        testMainView_CreateTask()
        let app = XCUIApplication()
        let newTaskTitle = "NewTaskTest"
        let tablesQuery = app.tables
        app.buttons["Get Stared"].tap()
        app.buttons["add"].tap()
        
        let titleTextField = tablesQuery.textFields["Title"]
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
