//
//  Sheet.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

public enum Sheet: Identifiable {

    public var id: UUID {
        
        return UUID()
    }
    
    case seetings
    case cityDetailView
}
