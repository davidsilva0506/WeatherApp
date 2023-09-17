//
//  SettingsView.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var navigation: Navigation
    
    @Binding var currentUnit: UnitType
    
    var body: some View {
        
        ZStack {
            
            Background()
            
            VStack {
                
                HStack {
                    
                    Spacer()
                            
                    CloseButton()
                }
                .padding()
                
                Picker(selection: $currentUnit, label: Text("Select unit")) {
                    
                    ForEach(UnitType.allCases, id: \.self) {
                        
                        Text($0.rawValue.capitalized)
                    }
                }
                .padding()
                .pickerStyle(.segmented)
                .onChange(of: settings.unit) { _ in
                    
                    navigation.activeSheet = nil
                }
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
       
        SettingsView(currentUnit: .constant(.celsius))
            .environmentObject(Settings())
    }
}
