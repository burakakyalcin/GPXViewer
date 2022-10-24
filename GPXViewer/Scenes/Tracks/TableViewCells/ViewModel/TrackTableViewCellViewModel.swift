//
//  File.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import UIKit
import CoreLocation

struct TrackTableViewCellViewModel: Equatable {
    let name: String
//    let image: UIImage?
    let coordinates: [CLLocationCoordinate2D]
    
    static func == (lhs: TrackTableViewCellViewModel, rhs: TrackTableViewCellViewModel) -> Bool {
        return lhs.name == rhs.name &&
        lhs.coordinates.map { $0.latitude } == rhs.coordinates.map { $0.latitude } &&
        lhs.coordinates.map { $0.longitude } == rhs.coordinates.map { $0.longitude }
    }
}
