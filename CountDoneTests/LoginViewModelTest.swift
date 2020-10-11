//
//  LoginViewModelTest.swift
//  CountDoneTests
//
//  Created by 段欣寰 on 2020/10/11.
//  Copyright © 2020 G33. All rights reserved.
//

import XCTest
@testable import CountDone

class LoginViewModelTest: XCTestCase {
    var log: LoginViewModel?
    
    override func setUp() {
        super.setUp()
        log = LoginViewModel()
        
    }
    
    override func tearDown() {
        log = nil
        super.tearDown()
        
    }
    
    func testLoginPosite() {
        XCTAssertTrue(log!.loginVerification(email: "duanxinhuan@163.com", password: "123a"))
        XCTAssertFalse(log!.loginVerification(email: "a", password: "b"))
        
    }
    

}
