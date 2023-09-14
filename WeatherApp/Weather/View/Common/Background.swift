//
//  Background.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation
import SwiftUI

struct Background: View {

    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                       startPoint: .topLeading,
                       endPoint: .topTrailing)
        .ignoresSafeArea()
    }
}
