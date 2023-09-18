//
//  WeatherImage.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

struct WeatherImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    
    let iconString: String
    
    var body: some View {
        
        RemoteImage(image: imageLoader.image)
            .task {
                
                await imageLoader.load(from: iconString)
            }
    }
}
