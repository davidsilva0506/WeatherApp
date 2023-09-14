//
//  RemoteImage.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

private enum Constants {
    
    static let placeHolderImage = "arrow.triangle.2.circlepath.camera"
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        
        image?.resizable() ?? Image(systemName: Constants.placeHolderImage).resizable()
    }
}
