//
//  CountDoneTests.swift
//  CountDoneTests
//
//  Created by Fanwei Wang on 6/8/20.
//  Copyright © 2020 G33. All rights reserved.
//

import XCTest
@testable import CountDone

class CountDoneTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUtilNegative(){
        let util = NetWorkUtil.util
        XCTAssertThrowsError(try util.StringToDate(dateString: "vnj vd")) { error in
            XCTAssertEqual(error as! dateFormatError, dateFormatError.runtimeError("fail to format string"))
        }
    }
    
    func testUtilPositive(){
        let util = NetWorkUtil.util
        let Date = try! util.StringToDate(dateString: "09/10/2020, 16:55:59")
        print(Date)
        let s = util.dateToString(date: Date)
        XCTAssertNotNil(Date)
        XCTAssertEqual(s, "09/10/2020, 16:55:59" )
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
