//
//  ErrorAlert.swift
//  Weather
//
//  Created by David Silva on 13/09/2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    
    let title: Text
    let message: Text
    let dismiss: Alert.Button
}

struct AlertContext {

    static let invalidURL = AlertItem(title: Text("Invalid"),
                                      message: Text("Something"),
                                      dismiss: .default(Text("Ok")))

    static let invalidData = AlertItem(title: Text("Invalid"),
                                       message: Text("Something"),
                                       dismiss: .default(Text("Ok")))
    
    static let requestFailed = AlertItem(title: Text("Invalid"),
                                         message: Text("Something"),
                                         dismiss: .default(Text("Ok")))
    
    static let parsingFailed = AlertItem(title: Text("Invalid"),
                                         message: Text("Something"),
                                         dismiss: .default(Text("Ok")))
}
