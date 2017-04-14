//
//  WindDirection.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation

enum WindDirection : String
{
    case N = "N", NNE = "NNE", NE = "NE", ENE = "ENE", E = "E", ESE = "ESE", SE = "SE", SSE = "SSE", S = "S", SSW = "SSW", SW = "SW", WSW = "WSW", W = "W", WNW = "WNW", NW = "NW", NNW = "NNW"
    
    init(degrees: Double)
    {
        switch degrees
        {
        case 348.75 ..< 360:
            fallthrough
        case 0 ..< 11.25:
            self = .N
        case 11.25 ..< 33.75:
            self = .NNE
        case 33.75 ..< 56.25:
            self = .NE
        case 56.25 ..< 78.75:
            self = .ENE
        case 78.75 ..< 101.25:
            self = .E
        case 101.25 ..< 123.75:
            self = .ESE
        case 123.75 ..< 146.25:
            self = .SE
        case 146.25 ..< 168.75:
            self =  .SSE
        case 168.75 ..< 191.25:
            self = .S
        case 191.25 ..< 213.75:
            self = .SSW
        case 213.75 ..< 236.25:
            self = .SW
        case 236.25 ..< 258.75:
            self = .WSW
        case 258.75 ..< 281.25:
            self = .W
        case 281.25 ..< 303.75:
            self = .WNW
        case 303.75 ..< 326.25:
            self = .NW
        case 326.25 ..< 348.75:
            self = .NNW
        default :
            self = .N
        }
    }
    
    
    
    
}
