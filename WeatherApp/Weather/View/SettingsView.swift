//
//  SettingsView.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var activeSheet: Sheet?

    var body: some View {
       
        VStack {
            
            HStack {
                
                Spacer()
                
                Button {
                   
                    activeSheet = nil
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.label))
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activeSheet: .constant(nil))
    }
}
