//
//  MockSessionProvider.swift
//
//  Created by Massimiliano Faustini on 23/03/17.
//  Copyright © 2017 Massimiliano Faustini. All rights reserved.
//

import Foundation

struct MockSessionProvider: NetworkSessionProviderProtocol
{
    enum ResultForMock {
        case succeeds,fails500,failsParsing
    }
    enum CallForMock {
        case callForForecast, callForImage
    }
    
    enum FakeErrors: Error {
        case fakeError
    }
    
    static var resultForMock: ResultForMock = .succeeds
    static var callForMock: CallForMock = .callForForecast

    static func defaultSession() -> URLSession {
        return MockSession()
    }
}

class MockSession: URLSession {
    final override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
    {
        let dataTask = MockURLSessionDataTask()
        let fakeError = MockSessionProvider.FakeErrors.fakeError
        
        // Pick right test data file for call
        var dataUrl: URL?
        switch MockSessionProvider.callForMock
        {
        case .callForImage:
            dataUrl = Bundle.main.url(forResource: "", withExtension: "png")
        case .callForForecast:
            dataUrl = Bundle.main.url(forResource: "forecastRawJustBody", withExtension: "json")
        }

        // configure mocked response
        switch MockSessionProvider.resultForMock {
        case .succeeds:
            // Data
            var data: Data? = nil
            data = try? Data(contentsOf: dataUrl!)

            
            // Response
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "", headerFields: nil)
            dataTask.taskResponse?.response = response
            
            // Set taskResponse
            dataTask.taskResponse = (data, response, nil)
            
            // Set completion hanlder
            dataTask.completionHandler = completionHandler
            
        case .fails500:
            // Response
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: "", headerFields: nil)
            dataTask.taskResponse?.response = response
            
            // Set taskResponse
            dataTask.taskResponse = (nil, response, fakeError)
            
            // Set completion hanlder
            dataTask.completionHandler = completionHandler
            
        case .failsParsing:
            let invalidString = "ebgsjv s"
            let invalidData: Data? = invalidString.data(using: String.Encoding.utf8)
            
            // Response
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "", headerFields: nil)
            dataTask.taskResponse?.response = response
            
            // Set taskResponse
            dataTask.taskResponse = (invalidData, response, nil)
            
            // Set completion hanlder
            dataTask.completionHandler = completionHandler
        }
        
        return dataTask
    }
}

final private class MockURLSessionDataTask : URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    typealias TaskResponse = (data: Data?, response: URLResponse?, error: Error?)
    
    var completionHandler: CompletionHandler?
    var taskResponse: TaskResponse?
    
    override func resume()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        {
            // self deliberately left strong here
            self.completionHandler?(self.taskResponse?.data
                , self.taskResponse?.response, self.taskResponse?.error)
            self.completionHandler = nil
        }
    }
}
