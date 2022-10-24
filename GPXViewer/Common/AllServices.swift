//
//  AllServices.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

protocol TracksRepositoryProvider {
    var tracksRepository: TracksRepositoryProtocol { get }
}

typealias ServicesProvider = TracksRepositoryProvider

struct AllServices: ServicesProvider {
    let tracksRepository: TracksRepositoryProtocol
}
