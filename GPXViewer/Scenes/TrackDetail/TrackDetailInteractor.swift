//
//  TrackDetailInteractor.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

protocol TrackDetailInteractorDelegate: AnyObject {
    
}

class TrackDetailInteractor {
    typealias Context = TracksRepositoryProvider
    
    weak var delegate: TrackDetailInteractorDelegate?
    private let context: Context
    let track: Track

    init(track: Track, context: Context) {
        self.context = context
        self.track = track
    }
}
