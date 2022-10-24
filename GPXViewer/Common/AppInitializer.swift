//
//  AppInitializer.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

struct AppInitializer {
    static func createAppContext() -> AppContext {
        let tracksMapper: any MapperProtocol<Data, Track> = TrackMapper()
        let tracksParser: any ParserProtocol<String, Track> = TrackParser(mapper: tracksMapper)
        let tracksFactory: any FactoryProtocol<Track> = TracksFactory(parser: tracksParser)
        let tracksRepository = TracksRepository(tracksFactory: tracksFactory)
        let services = AllServices(tracksRepository: tracksRepository)
        return AppContext(services: services)
    }
}
