//
//  OnboardingView.swift
//  City Sights
//
//  Created by Léa Dukaez on 11/09/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model: ContentModel
    @State private var tabSelection = 0
    
    var body: some View {

        VStack {
                Spacer()
                // TabView
                TabView(selection: $tabSelection,
                        content:  {
                            // First Tab
                            VStack (spacing: 20) {
                                Image("city0").resizable().scaledToFit()
                                Text("Welcome to City Sights!").bold().font(.title)
                                Text("City Sights helps you find the best of the city")
                            }.tag(0)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            
                            // Second tab
                            VStack (spacing: 20) {
                                Image("city1").resizable().frame(width:200, height: 200)
                                Text("Ready to discover your city?").bold().font(.title)
                                Text("We will show you the best restaurants, venues and more, based on your location!")
                            }.tag(1)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        })
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .padding()
                
                // Button
                Button(action: {
                    // Detect tab
                    if tabSelection == 0 {
                        tabSelection = 1
                    } else {
                        // TO DO : request for geolocation
                        model.requestGeoloocationPermission()
                    }
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 48)
                            .cornerRadius(8)
                        
                        Text( tabSelection == 0 ? "Next" : "Get My Location")
                            .bold()
                            .padding()
                            .foregroundColor(tabSelection == 0 ? K.onboardingColorView1 : K.onboardingColorView2)
                    }
                }).padding()
            
                Spacer()
            }
        .background(tabSelection == 0 ? K.onboardingColorView1 : K.onboardingColorView2)
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
