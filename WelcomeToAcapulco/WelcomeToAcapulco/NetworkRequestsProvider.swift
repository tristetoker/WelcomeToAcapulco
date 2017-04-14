//
//  NetworkRequestsProvider.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation

enum NetworkRequestsProviderErrors: Error
{
    case URLForCurrentWeatherInvalid
}

struct NetworkRequestsProvider: NetworkRequestsProviderProtocol
{
    static var baseURL = "http://api.openweathermap.org/"
    static var componentForecastService = "data/2.5/forecast?"
    static var componentConditionIconService = "img/w/"
    static var extensionPng = ".png"

    static var componentCity = "id="
    static var componentKey = "APPID=13a5b3c1a3e10575551ec4b5483dc854"
    
    static var timeoutInterval: TimeInterval = 30.0
    
    func requestForWeatherForecastFor(cityId: Int) throws -> URLRequest {
        guard let url = URL(string: urlStringForForecast(cityId: cityId)) else
        {
            print("error while creating the url")
            throw NetworkRequestsProviderErrors.URLForCurrentWeatherInvalid
        }
        let request = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: NetworkRequestsProvider.timeoutInterval)
        
        return request
    }
    
    func requestForConditionImageFor(icon: String) throws -> URLRequest {
        guard let url = URL(string: urlStringForConditionImageFor(icon: icon)) else
        {
            print("error while creating the url")
            throw NetworkRequestsProviderErrors.URLForCurrentWeatherInvalid
        }
        let request = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: NetworkRequestsProvider.timeoutInterval)
        
        return request
    }
    
    func urlStringForConditionImageFor(icon: String) -> String
    {
        return NetworkRequestsProvider.baseURL + NetworkRequestsProvider.componentConditionIconService + icon + NetworkRequestsProvider.extensionPng
    }

    func urlStringForForecast(cityId: Int) -> String
    {
        return NetworkRequestsProvider.baseURL + NetworkRequestsProvider.componentForecastService + NetworkRequestsProvider.componentCity + String("\(cityId)&") + NetworkRequestsProvider.componentKey
    }
}
