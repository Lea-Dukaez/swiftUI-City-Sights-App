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
    @Binding var selectedBusiness: Business?
    
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
        
        // Detect event in the MapView  through the delegate and we assign the coordinator as the delegate
        mapView.delegate = context.coordinator
        
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
    
    
    // MARK - Coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parentMap: BusinessMap
        
        init(map: BusinessMap) {
            self.parentMap = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            
            // Check if there is a reusable annotationView first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: K.annotationReuseID)
            if annotationView == nil {
                // Create a new annotation View
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: K.annotationReuseID)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // We got a reusable one
                annotationView!.annotation = annotation
            }
            
            // return it
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // User tapped on the annotation view - The coordinator need access to the businessMap to acces selectedBusiness property and the model to loop through the business so we add the special init method to the Coordinator to pass the map.
            // Get the business object that this annotation represents
            
            for business in parentMap.model.restaurants + parentMap.model.sights {
                if business.name == view.annotation?.title {
                    // Setthe selectedBusiness property to that business object
                    parentMap.selectedBusiness = business
                    return
                }
            }
        }
    }
}
