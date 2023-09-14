//
//  String+Escaped.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation

extension String {
    
    func escaped() -> String {
        
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
