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
        app.navigationBars["Today"].buttons["Menu"].tap()
        let home = app.tables.staticTexts["Home"]
        XCTAssert(home.exists)
        
        
        
    }
    
    
    
    
    
}
