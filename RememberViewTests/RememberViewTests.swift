//
//  RememberViewTests.swift
//  RememberViewTests
//
//  Created by pegasus on 2016/11/26.
//  Copyright © 2016年 Kelly. All rights reserved.
//

import XCTest

class RememberViewTests: XCTestCase {
    
  func testMealInit() {
    // success case
    let meal = Meal(name: "我的甜點", photo: nil, rating: 5)
    XCTAssertNotNil(meal)
    
    // failure case
    let noname = Meal(name: "", photo: nil, rating: 0)
    XCTAssertNil(noname, "Empty name is invalid")
    
    let badRating = Meal(name: "bad rating", photo: nil, rating: -1)
    XCTAssertNil(badRating, "Negative rating is invalid")
  }
    
}
