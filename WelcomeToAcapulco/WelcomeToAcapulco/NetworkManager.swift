//
//  NetworkManager.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NetworkManagerProtocol
{
    private static var privateSharedManager = NetworkManager()
    
    private init(){}
    
    var requestProvider : NetworkRequestsProviderProtocol?
    var sessionProvider : NetworkSessionProviderProtocol?
    var responseParser: NetworkResponseParserProtocol?
    
    static func sharedManager(with requestProvider: NetworkRequestsProviderProtocol, sessionProvider: NetworkSessionProviderProtocol, responseParser: NetworkResponseParserProtocol) -> NetworkManagerProtocol {
        privateSharedManager.requestProvider = requestProvider
        privateSharedManager.sessionProvider = sessionProvider
        privateSharedManager.responseParser = responseParser
        
        return privateSharedManager
    }
    
    func callForForecastFor(cityId: Int, completionHandler: @escaping (_ succeeded: Bool, _ error: NetworkManagerProtocolErrors?, _ forecast: Forecast?) -> ()) throws -> URLSessionDataTask? {
        guard requestProvider != nil, sessionProvider != nil, responseParser != nil else {             throw NetworkManagerProtocolErrors.CallCouldntStart }
        
        do
        {
            // Retrieve session
            let sessionProviderType = type(of: sessionProvider!)
            let session = sessionProviderType.defaultSession()
            
            let request = try requestProvider!.requestForWeatherForecastFor(cityId: cityId)
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error)
                
                in
                guard let httpResponse = response as? HTTPURLResponse else
                {
                    completionHandler(false, NetworkManagerProtocolErrors.InvalidResponseType, nil)
                    return
                }
                
                guard ((200 ... 299).contains(httpResponse.statusCode)) else
                {
                    completionHandler(false, NetworkManagerProtocolErrors.ResponseCodeUnsuccesfull, nil)
                    return
                }
                
                guard (data != nil) else
                {
                    completionHandler(false, NetworkManagerProtocolErrors.ResponseEmpty, nil)
                    return
                }
                
                do
                {
                    let forecast = try self.responseParser?.parseDataForWeatherForecast(data: data)
                    completionHandler(true, nil, forecast)
                    return
                }
                catch
                {
                    completionHandler(false, NetworkManagerProtocolErrors.JsonCouldntBeParsed, nil)
                    return
                }
            })
            task.resume()
            return task
        }
        catch
        {
            throw NetworkManagerProtocolErrors.CallCouldntStart
        }
    }
    
    func callForConditionImageFor(icon: String, completionHandler: @escaping (_ succeeded: Bool, _ error: NetworkManagerProtocolErrors?, _ image: UIImage?) -> ()) throws -> URLSessionDataTask? {
        guard requestProvider != nil, sessionProvider != nil, responseParser != nil else {             throw NetworkManagerProtocolErrors.CallCouldntStart }
        
        do
        {
            // Retrieve session
            let sessionProviderType = type(of: sessionProvider!)
            let session = sessionProviderType.defaultSession()
            
            let request = try requestProvider!.requestForConditionImageFor(icon: icon)
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error)
                
                in
                guard let httpResponse = response as? HTTPURLResponse else
                {
                    completionHandler(false, NetworkManagerProtocolErrors.InvalidResponseType, nil)
                    return
                }
                
                guard ((200 ... 299).contains(httpResponse.statusCode)) else
                {
                    completionHandler(false, NetworkManagerProtocolErrors.ResponseCodeUnsuccesfull, nil)
                    return
                }
                
                guard let nonNilData = data else
                {
                    completionHandler(false, NetworkManagerProtocolErrors.ResponseEmpty, nil)
                    return
                }
                
                guard let image = UIImage(data: nonNilData) else {                     completionHandler(false, NetworkManagerProtocolErrors.ImageCouldntBeCreated, nil)
                    return
                }
                
                completionHandler(true, nil, image)
            })
            task.resume()
            return task
        }
        catch
        {
            throw NetworkManagerProtocolErrors.CallCouldntStart
        }

    }
    
    
}
