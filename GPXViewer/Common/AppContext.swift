//
//  AppContext.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

typealias AppContextProtocol = ServicesProvider

struct AppContext: AppContextProtocol {
    let services: ServicesProvider

    var tracksRepository: TracksRepositoryProtocol {
        services.tracksRepository
    }
}
