//
//  Weather.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation

struct Weather: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}
