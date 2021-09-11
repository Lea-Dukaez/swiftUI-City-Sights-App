//
//  ContentView.swift
//  City Sights
//
//  Created by Léa Dukaez on 08/09/2021.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization status of geolocation the user
        if model.authorizationState == .notDetermined {
            // If undetermined, show onboarding
            OnboardingView()
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            // If approved, show Home View
            HomeView()
        }
        else {
            // If denied show denied view
            LocationDeniedView()
        }
    }
}

struct LaunchView_Preview: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
