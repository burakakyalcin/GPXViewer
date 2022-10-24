//
//  TracksViewModelBuilder.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import UIKit
import CoreLocation

struct TracksViewModelBuilder {
    static func build(with state: TracksInteractor.State) -> TracksViewModel {
        return TracksViewModel(
            tracks: state.tracks,
            items: state.tracks.map {
                TrackTableViewCellViewModel(
                    name: $0.name,
                    coordinates: $0.trackDetails.map {
                        CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    }
                )
            }
        )
    }
}
