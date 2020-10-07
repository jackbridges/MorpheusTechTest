//
//  LogInViewModelTests.swift
//  MorpheusTechTaskTests
//
//  Created by Jack Bridges on 06/10/2020.
//

import XCTest
@testable import MorpheusTechTask

class LogInViewModelTests: XCTestCase {
    
    var viewModel: LogInViewModel?
    
    override func setUpWithError() throws {
        self.viewModel = LogInViewModel(coreDataService: CoreDataService())
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
    }
    
    func testAuthenticateLogIn() {
        var validCall = false
        let expectation = self.expectation(description: "Checking Credentials")
        
        self.viewModel?.authenticateLogInCredentials(username: "user@morpheustest.com", password: "Password1", completion: { (error, validLogIn) in
            validCall = validLogIn
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(validCall, true)
    }
    
    func testAuthenticateLogInWrongPassword() {
        var logInError: LogInError?
        let expectation = self.expectation(description: "Checking Credentials")
        
        self.viewModel?.authenticateLogInCredentials(username: "jack bridges", password: "Password", completion: { (error, valid) in
            logInError = error as? LogInError
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(logInError, LogInError.logInFailed)
    }
}
