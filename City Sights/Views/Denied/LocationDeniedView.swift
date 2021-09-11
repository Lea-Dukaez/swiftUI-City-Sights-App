//
//  LocationDeniedView.swift
//  City Sights
//
//  Created by Léa Dukaez on 11/09/2021.
//

import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Whoops!").bold().font(.title).padding(.bottom, 20)
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings.")
            Spacer()
            Button(action: {
                // Open Settings Location
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        // If we can open this settings url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            }, label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(8)
                    
                    Text("Go to Settings")
                        .bold()
                        .padding()
                        .foregroundColor(K.onboardingColorDeniedView)
                }
            }).padding()
            Spacer()
        }.foregroundColor(.white).multilineTextAlignment(.center)
        .background(K.onboardingColorDeniedView)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
