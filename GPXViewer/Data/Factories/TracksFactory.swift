//
//  TracksFactory.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

protocol FactoryProtocol<T> {
    associatedtype T
    func fetch() -> [T]
}

class TracksFactory: FactoryProtocol {
    typealias T = Track
    
    private let parser: any ParserProtocol<String, Track>
    
    init(parser: any ParserProtocol<String, Track>) {
        self.parser = parser
    }
    
    func fetch() -> [Track] {
        let resourcePaths = BundleManager.fetchResourcePaths(for: "Resources", resourceType: "gpx", inDirectory: "Tracks")
        var tracks: [Track] = []
        
        for resourcePath in resourcePaths {
            guard let track = parser.parse(from: resourcePath) else { continue }
            tracks.append(track)
        }
        
        return tracks
    }
}

protocol Generic {
    
    associatedtype T
    associatedtype U

    static func operation(_ t: T) -> U
}


// Use Generic Protocol

class Test: Generic {

    typealias T = Animal
    typealias U = Any
    
    static func operation(_ t: Animal) -> Any {
        let dict = ["name":"saurabh"]
        return dict
    }
}

struct Animal {
    let name: String
}
