//
//  ProfileViewModelTests.swift
//  MorpheusTechTaskTests
//
//  Created by Jack Bridges on 06/10/2020.
//

import XCTest
@testable import MorpheusTechTask

class ProfileViewModelTests: XCTestCase {

    var viewModel: ProfileViewModel?
    
    override func setUpWithError() throws {
        self.viewModel = ProfileViewModel(coreDataService: CoreDataService())
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
    }
    
    func testSortArrayOnRating() {
        let unsortedArray = [Profile(name: "Jack", star_level: 1, distance_from_user: "0.2m", num_ratings: 40, profile_image: "dummyURL.com"), Profile(name: "Jimmy", star_level: 2, distance_from_user: "0.8m", num_ratings: 10, profile_image: "dummyURL.com"), Profile(name: "Stephen", star_level: 3, distance_from_user: "2m", num_ratings: 8, profile_image: "dummyURL.com")]
        
        let sortedArray = self.viewModel?.getSortedArray(profileArray: unsortedArray)
        XCTAssertTrue(sortedArray?.first?.name == "Stephen" && sortedArray?.first?.star_level == 3)
    }
}
