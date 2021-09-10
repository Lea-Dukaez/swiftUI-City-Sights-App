//
//  BusinessMap.swift
//  City Sights
//
//  Created by Léa Dukaez on 10/09/2021.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var locations:[MKPointAnnotation] {
        // Create a set of annotations from our list of businesses
        var annotations = [MKPointAnnotation]()
        
        
        for business in model.restaurants + model.sights {
            // If the business as lat + lon creat an MKPointAnnotation for it
            if let lat = business.coordinates?.latitude , let long = business.coordinates?.longitude {
                // Create a new annotion
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        return annotations
    }

    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // MAke the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // is called severals times as the data changes
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
