//
//  CloseButton.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import Foundation
import SwiftUI

struct CloseButton: View {
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        
        Button {
           
            activeSheet = nil
            
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .imageScale(.large)
                .frame(width: 44, height: 44)
        }
    }
}
