//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Jane Appleseed on 5/23/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit
import XCTest

class FoodTrackerTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    
    // Confirm Meal initilizer returns given no name or negative rating
    func testMealInitialization() {
        // success
        let potentialItem = Meal(name: "new", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really Bad Rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid")
        
    }
}