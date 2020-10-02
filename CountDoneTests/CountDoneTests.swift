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

    //positive tests for the fetch user function
    func testApiFectchPositive() {
        let rest = REST_Request()
        rest.emptyUsers()
        rest.getUsers(withEmail: "duanxinhuan@163.com")
        sleep(1)
        let users =  rest.getAccounts()
        XCTAssertEqual(users.count, 3, "there are 3 users intotal")
        XCTAssertTrue(rest.filterId())
    }
    
    //negative test for the fetch user function
    func testApiFetchNegative(){
        let rest = REST_Request()
        rest.emptyUsers()
        let users =  rest.getAccounts()
        XCTAssertEqual(users.count, 0, "there are 3 users intotal")
        XCTAssertFalse(rest.filterId())
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
