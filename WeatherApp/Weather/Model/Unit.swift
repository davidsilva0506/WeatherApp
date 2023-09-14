//
//  Unit.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation

public enum UnitType: String, CaseIterable, Identifiable {

    case fahrenheit
    case celsius
    case kelvin
    
    public var id: String {
        
        return UUID().uuidString
    }
    
    public var value: String {

        switch self {
            
        case .fahrenheit:
            return "imperial"
        case .celsius:
            return "metric"
        case .kelvin:
            return ""
        }
    }
    
    public var symbol: String {

        switch self {
            
        case .fahrenheit:
            return "ºF"
        case .celsius:
            return "ºC"
        case .kelvin:
            return "K"
        }
    }
    
    public var index: Int {

        switch self {
            
        case .fahrenheit:
            return 0
        case .celsius:
            return 1
        case .kelvin:
            return 2
        }
    }
}
