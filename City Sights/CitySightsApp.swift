//
//  City_SightsApp.swift
//  City Sights
//
//  Created by Léa Dukaez on 08/09/2021.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(ContentModel())
        }
    }
}
