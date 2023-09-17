//
//  ErrorAlert.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

private enum Constants {
    
    static let errorTitle = "Oops"
    static let errorMessage = "Something went wrong."
    static let dismissText = "Ok"
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
    
    static let requestFailed = AlertItem(title: Text(Constants.errorTitle),
                                         message: Text(Constants.errorMessage),
                                         dismiss: .default(Text(Constants.dismissText)))
}
