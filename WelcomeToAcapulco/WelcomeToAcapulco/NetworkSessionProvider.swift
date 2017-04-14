//
//  NetworkSessionProvider.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation

struct NetworkSessionProvider: NetworkSessionProviderProtocol
{
    private static var privateSession : URLSession!
    
    static func defaultSession() -> URLSession
    {
        guard (privateSession == nil) else
        {
            return privateSession
        }
        
        let defaultConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: defaultConfiguration)
        privateSession = session
        
        return privateSession
    }
    
}
