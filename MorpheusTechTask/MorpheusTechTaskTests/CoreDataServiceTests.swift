//
//  CoreDataServiceTests.swift
//  MorpheusTechTaskTests
//
//  Created by Jack Bridges on 06/10/2020.
//

import XCTest
@testable import MorpheusTechTask

class CoreDataServiceTests: XCTestCase {
    
    var coreDataService: CoreDataService?

    override func setUpWithError() throws {
        self.coreDataService = CoreDataService()
    }

    override func tearDownWithError() throws {
        self.coreDataService = nil
    }

    func testSaveAuthTokenToContainer() throws {
        XCTAssertNoThrow(try self.coreDataService?.saveAuthTokenToContainer(authToken: "coheroiherc"))
    }
    
    func testGetAuthToken() {
        // needed to add an auth token to be able to test getting it out
        try? self.coreDataService?.saveAuthTokenToContainer(authToken: "Hello")
        let retrievedAuthToken = try? self.coreDataService?.getAuthToken()
        XCTAssertTrue(retrievedAuthToken == "Hello")
    }

    func testDeleteTokens() throws {
        XCTAssertNoThrow(try self.coreDataService?.deletePreviousTokens())
    }
}
