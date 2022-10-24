//
//  TracksRepository.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

protocol TracksRepositoryProtocol {
    func getTracks() -> [Track]
}

class TracksRepository: TracksRepositoryProtocol {

    private let tracksFactory: any FactoryProtocol<Track>

    init(tracksFactory: any FactoryProtocol<Track>) {
        self.tracksFactory = tracksFactory
    }

    func getTracks() -> [Track] {
        return tracksFactory.fetch()
    }
}
