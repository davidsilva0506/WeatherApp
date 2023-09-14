//
//  EmptyCityListView.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import Foundation
import SwiftUI

private enum Constants {

    static let globe = "globe"
    static let emptyText = "Search a new city"
    static let emptyImageWidth: CGFloat = 150
    static let emptyImageHeight: CGFloat = 150
}

struct EmptyCityListView: View {

    var body: some View {

        VStack {
            
            Image(systemName: Constants.globe)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.emptyImageWidth, height: Constants.emptyImageHeight)
            
            Text(Constants.emptyText)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}
