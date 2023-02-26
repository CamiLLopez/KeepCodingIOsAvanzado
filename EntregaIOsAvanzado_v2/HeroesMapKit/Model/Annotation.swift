//
//  Annotation.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 26/2/23.
//

import Foundation
import MapKit
import CoreLocation


class Annotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let name: String
    let image: String
    
    init(place: PlaceModel) {
        
        coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        name = place.name
        image = place.image
    }
}
