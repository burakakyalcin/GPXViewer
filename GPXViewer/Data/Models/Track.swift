//
//  Track.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

struct Track: Equatable {
    let name: String
    let trackDetails: [TrackDetail]
}

struct TrackDetail: Equatable {
    let latitude: Double
    let longitude: Double
    let time: Date?
    let azimuth: String?
    let speedInKnots: String?
    let horizontalAccuracy: String?
    let ticks: String?
}
