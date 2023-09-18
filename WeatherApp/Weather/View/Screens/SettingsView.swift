//
//  SettingsView.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    private enum Constants {
        
        static let pickerLabelText = "Select unit"
    }

    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject private var settings: Settings
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Picker(selection: $settings.unit, label: Text(Constants.pickerLabelText)) {
                    
                    ForEach(UnitType.allCases, id: \.self) {
                        
                        Text($0.rawValue.capitalized)
                    }
                }
                .padding()
                .pickerStyle(.segmented)
                
                Spacer()
            }
            .navigationTitle("Settings")
            .toolbar {
                
                CloseButton()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
       
        SettingsView()
            .environmentObject(Settings())
    }
}
