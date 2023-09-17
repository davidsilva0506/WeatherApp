//
//  ImageLoader.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    
    private let service = ServiceLayer()
    private let imageCache = NSCache<NSString, UIImage>()

    @Published var image: Image? = nil
    
    func load(from iconString: String) async {

        if let cachedImage = imageCache.object(forKey: iconString as NSString) {

            self.image = Image(uiImage: cachedImage)
        }

        guard let uiImage = await service.fetchImage(iconString: iconString) else { return }
        
        self.imageCache.setObject(uiImage, forKey: iconString as NSString)
        
        self.image = Image(uiImage: uiImage)
    }
}
