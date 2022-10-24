//
//  TracksViewModel.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import Foundation

struct TracksViewModel: Equatable {
    let tracks: [Track]
    let items: [TrackTableViewCellViewModel]
}
