//
//  ErrorAlert.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

private enum Constants {
    
}

struct AlertItem: Identifiable {
    
    var id: String {
    
        return UUID().uuidString
    }
    
    let title: Text
    let message: Text
    let dismiss: Alert.Button
}

struct AlertContext {
    
    static let requestFailed = AlertItem(title: Text("Oops"),
                                         message: Text("Something went wrong."),
                                         dismiss: .default(Text("Ok")))
}
