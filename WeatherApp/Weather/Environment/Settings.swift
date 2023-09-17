//
//  Settings.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation
import SwiftUI

final class Settings: ObservableObject {
    
    @Published var unit: UnitType = .celsius
}
