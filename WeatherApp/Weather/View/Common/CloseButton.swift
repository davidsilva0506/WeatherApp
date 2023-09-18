//
//  CloseButton.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

private enum Constants {

    static let imageName = "xmark"
    static let imageSize: CGFloat = 44
}

struct CloseButton: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        Button {
           
            dismiss()
            
        } label: {
            
            Image(systemName: Constants.imageName)
                .imageScale(.large)
                .frame(width: Constants.imageSize, height: Constants.imageSize)
        }
    }
}
