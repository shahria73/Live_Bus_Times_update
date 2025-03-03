//
//  DriverAnnotation.swift
//  Live Bus Time
//
//  Created by Kabir on 22/04/2019.
//  Copyright © 2019 Kabir. All rights reserved.
//

import Foundation
import MapKit

//annotation for driver to show in the display , inherit from NSObject and MKAnnotation
class DriverAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, withKey key: String){
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
    
    func update(annotationPosition annotation: DriverAnnotation, withCoordinate coordinate: CLLocationCoordinate2D) {
        var location = self.coordinate
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        UIView.animate(withDuration: 0.2) {
            self.coordinate = location
        }
    }
}
