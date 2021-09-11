//
//  DirectionsMap.swift
//  City Sights
//
//  Created by Léa Dukaez on 11/09/2021.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    var business: Business
    
    
    var start: CLLocationCoordinate2D {
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            return CLLocationCoordinate2D()
        }
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        //Create map
         let map  = MKMapView()
        map.delegate = context.coordinator
        
        //Show the user location
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        // Create directions request
        let request  = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // Create directions objects
        let directions = MKDirections(request: request)
        
        // Calculate route
        directions.calculate { response, error in
            if error == nil && response != nil {
                
                for route in response!.routes {
                    // Plot the route on the map
                    map.addOverlay(route.polyline)
                    
                    // Zoom into the region
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                }
                
            }
        }
        // PLace annotatin for the end point
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        map.addAnnotation(annotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        // Implement the method to design  the overlay directions
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            
            renderer.lineWidth = 5
            renderer.strokeColor = .blue
            
            return renderer
        }
        
    }

}
