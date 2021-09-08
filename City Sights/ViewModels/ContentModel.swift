//
//  ContentModel.swift
//  City Sights
//
//  Created by Léa Dukaez on 08/09/2021.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override init() {
        // Init method of NSObject
        super.init()
        
        // Set ContentModel as Delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            // We have permission
            // Start geolocating the user , after we get permission
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gives us the locaton of the user
        print(locations.first ?? "no location")
        
        // TODO: if we have the coordinates of the user, send into Yelp API
        
        // Stop requesting the location after we get it once
        locationManager.startUpdatingLocation()
    }
    
}
