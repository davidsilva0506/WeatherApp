//
//  SettingsView.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: Settings
    
    @Binding var activeSheet: Sheet?
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                HStack {
                    Spacer()
                    CloseButton(activeSheet: $activeSheet)
                }
                .padding()
                
                Picker(selection: $settings.unit, label: Text("Select unit")) {
                    ForEach(UnitType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .padding()
                .pickerStyle(.segmented)
                .onChange(of: settings.unit) { newValue in
                    settings.unit = newValue
                }
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activeSheet: .constant(nil))
            .environmentObject(Settings())
    }
}
