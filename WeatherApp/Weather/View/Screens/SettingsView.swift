//
//  SettingsView.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject private var settings: Settings
    
    var body: some View {
            
        VStack {
            
            HStack {
                
                Spacer()
                        
                CloseButton()
            }
            .padding()
            
            Picker(selection: $settings.unit, label: Text("Select unit")) {
                
                ForEach(UnitType.allCases, id: \.self) {
                    
                    Text($0.rawValue.capitalized)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
       
        SettingsView()
            .environmentObject(Settings())
    }
}
