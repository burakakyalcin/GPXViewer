//
//  TrackMapper.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation
import CoreGPX

protocol MapperProtocol<T, U> {
    associatedtype T
    associatedtype U
    func map(item: T) -> U?
}

class TrackMapper: MapperProtocol {
    func map(item: Data) -> Track? {
        guard
            let gpxRoot = GPXParser(withData: item).parsedData(),
            let track = gpxRoot.tracks.first,
            let name = track.name,
            let segment = track.segments.first
        else {
            return nil
        }

        var trackDetails: [TrackDetail] = []
        
        for point in segment.points {
            guard let latitude = point.latitude, let longitude = point.longitude else { return nil }
            let time = point.time
            let azimuth = point.extensions?.children.first?.attributes["azimuth"]
            let speedInKnots = point.extensions?.children.first?.attributes["speedInKnots"]
            let horizontalAccuracy = point.extensions?.children.first?.attributes["horizontalAccuracy"]
            let ticks = point.extensions?.children.first?.attributes["ticks"]
            
            trackDetails.append(
                TrackDetail(
                    latitude: latitude,
                    longitude: longitude,
                    time: time,
                    azimuth: azimuth,
                    speedInKnots: speedInKnots,
                    horizontalAccuracy: horizontalAccuracy,
                    ticks: ticks
                )
            )
        }
        
        return Track(name: name, trackDetails: trackDetails)
    }
}
