//
//  WindDirectionTests.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 14/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import XCTest

class WindDirectionTests: XCTestCase {
    
    var sut: WindDirection?
    
    override func setUp() {
        super.setUp()
        sut = WindDirection(degrees: 0)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDirections() {
        
        XCTAssert(sut?.rawValue == "N")
        
        sut = WindDirection(degrees: 11.24)
        XCTAssert(sut?.rawValue == "N")
        
        sut = WindDirection(degrees: 11.25)
        XCTAssert(sut?.rawValue == "NNE")
        
        sut = WindDirection(degrees: 11.25)
        XCTAssert(sut?.rawValue == "NNE")
        
        sut = WindDirection(degrees: 33.74)
        XCTAssert(sut?.rawValue == "NNE")
        
        sut = WindDirection(degrees: 33.75)
        XCTAssert(sut?.rawValue == "NE")
        
        // ... continues
    }
    
    
}
