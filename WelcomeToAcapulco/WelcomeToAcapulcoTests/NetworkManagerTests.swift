//
//  NetworkManagerTests.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 14/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import XCTest
@testable import WelcomeToAcapulcoForTests

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManagerProtocol?
    static let epsilon = 0.000001
    
    override func setUp()
    {
        super.setUp()
        sut = NetworkManager.sharedManager(with: NetworkRequestsProvider(), sessionProvider: MockSessionProvider(), responseParser: NetworkResponseParser())
    }
    
    override func tearDown()
    {
        sut = nil
        super.tearDown()
    }
    
    func testSharedManager()
    {
        XCTAssert(sut is NetworkManager)
    }
    

    
    func testForecastSucceed()
    {
        let expect = expectation(description: "Network call to be mocked")
        
        MockSessionProvider.resultForMock = .succeeds
        MockSessionProvider.callForMock = .callForForecast
        
        // perform test
        do {
            let dataTask = try? sut?.callForForecastFor(cityId: 3533462, completionHandler: { (success, error, forecast) in
                
                XCTAssert(success)
                XCTAssert(error == nil)
                XCTAssert(forecast?.arrayOfWeather.count == 36)
                
                let weather0 = forecast?.arrayOfWeather.first
                XCTAssert(weather0?.cityIdentifier == 3533462)
                XCTAssert(abs((weather0?.windSpeed)! - 2.06000000000000018) < NetworkManagerTests.epsilon)
                XCTAssert(abs((weather0?.windDeg)! - 9.0001800000000003) < NetworkManagerTests.epsilon)
                
                // ... check some others in array ...
                
                expect.fulfill()
            })
            XCTAssert(dataTask is URLSessionTask)
        }
        waitForExpectations(timeout: 0.2)
    }
    
    
    func testForecastFailedDueToNetwork()
    {
        let expect = expectation(description: "Network call to be mocked")
        
        MockSessionProvider.resultForMock = .fails500
        MockSessionProvider.callForMock = .callForForecast
        
        do
        {
            let dataTask = try? sut?.callForForecastFor(cityId: 3533462, completionHandler: { (success, error, forecast) in
                
                XCTAssert(!success)
                XCTAssert(error == NetworkManagerProtocolErrors.ResponseCodeUnsuccesfull)
                XCTAssert(forecast == nil)
                expect.fulfill()
            })
            XCTAssert(dataTask is URLSessionTask)
        }

        
        waitForExpectations(timeout: 0.2)
    }
    
    func testForecastFailedDueToParsing()
    {
        let expect = expectation(description: "Network call to be mocked")
        
        MockSessionProvider.resultForMock = .failsParsing
        MockSessionProvider.callForMock = .callForForecast
        
        // perform test
        do
        {
            let dataTask = try? sut?.callForForecastFor(cityId: 3533462, completionHandler: { (success, error, forecast) in
                
                XCTAssert(!success)
                XCTAssert(error == NetworkManagerProtocolErrors.JsonCouldntBeParsed)
                XCTAssert(forecast == nil)
                expect.fulfill()
            })
            XCTAssert(dataTask is URLSessionTask)
        }
  
        
        waitForExpectations(timeout: 0.2)
    }
    
}
