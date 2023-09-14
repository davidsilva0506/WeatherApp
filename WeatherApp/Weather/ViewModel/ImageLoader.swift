//
//  ImageLoader.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    private let service = ServiceLayer()
    
    func load(from iconString: String) async {
        
        guard let uiImage = await service.fetchImage(iconString: iconString) else { return }
        
        self.image = Image(uiImage: uiImage)
    }
}
