//
//  WeatherImage.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

struct WeatherImage: View {
    
    @StateObject private var imageLoader: ImageLoader
    
    let iconString: String
    
    init(service: ServiceLayer, iconString: String) {
        
        _imageLoader = StateObject(wrappedValue: ImageLoader(service: service))
        self.iconString = iconString
    }
    
    var body: some View {
        
        RemoteImage(image: imageLoader.image)
            .task {
                
                await imageLoader.load(from: iconString)
            }
    }
}
