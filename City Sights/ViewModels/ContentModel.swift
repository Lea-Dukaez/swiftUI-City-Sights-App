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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // We have a location
            // Stop requesting the location after we get it once
            locationManager.startUpdatingLocation()
            
            // TODO: if we have the coordinates of the user, send into Yelp API
            getBusinesses(category: K.sightsKey, location: userLocation!)
            getBusinesses(category: K.restaurantsKey, location: userLocation!)
        }
        

    }
    
    // MARK - Yelp API methods
    
    func getBusinesses(category: String, location: CLLocation) {
        
        // CReate URL Request
        var urlComponents = URLComponents(string: K.yelpApiURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            // URL Object is not nil, we can proceed to the request
            // Create URL Request
            var request  = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer " + Secret.yelpAPIKey, forHTTPHeaderField: "Authorization")
            
            // GEt URL Sesssion
            let session = URLSession.shared
            
            // Create DataTask
            let task = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    // Parse data
                    guard data != nil else {
                        print("data retrieved is nil")
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            switch category {
                            case K.sightsKey:
                                self.sights = result.businesses
                            case K.restaurantsKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }
                        }
                    } catch {
                        print("error parsing data", error)
                    }
                }
                
            }
            
            // Start the task
            task.resume()
            
        }

    }
    
}
