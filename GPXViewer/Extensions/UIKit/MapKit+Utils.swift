//
//  MapKit+Utils.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import MapKit

extension MKCoordinateRegion {
    
    init?(coordinates: [CLLocationCoordinate2D]) {
        guard
            let minimumLatitude = coordinates.min(by:  { $0.latitude < $1.latitude })?.latitude,
            let minimumLongitude = coordinates.min(by:  { $0.longitude < $1.longitude })?.longitude,
            let maximumLatitude = coordinates.min(by:  { $0.latitude > $1.latitude })?.latitude,
            let maximumLongitude = coordinates.min(by:  { $0.longitude > $1.longitude })?.longitude
        else { return nil }
        
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: (maximumLatitude + minimumLatitude) / 2,
            longitude: (maximumLongitude + minimumLongitude) / 2
        )
        
        let span = MKCoordinateSpan(latitudeDelta: (maximumLatitude - minimumLatitude) * 1.2, longitudeDelta: (maximumLongitude - minimumLongitude) * 1.2)
        self = MKCoordinateRegion(center: centerCoordinate, span: span)
    }
}
