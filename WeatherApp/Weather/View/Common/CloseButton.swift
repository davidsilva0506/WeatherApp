//
//  CloseButton.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

struct CloseButton: View {
    
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        
        Button {
           
            navigation.activeSheet = nil
            
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .imageScale(.large)
                .frame(width: 44, height: 44)
        }
    }
}
