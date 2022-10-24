//
//  TrackParser.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 19/10/2022.
//

import Foundation
import CoreGPX

protocol ParserProtocol<T, U> {
    associatedtype T
    associatedtype U
    func parse(from: T) -> U?
}

class TrackParser: ParserProtocol {
    typealias T = String
    typealias U = Track
    
    private let mapper: any MapperProtocol<Data, Track>
    
    init(mapper: any MapperProtocol<Data, Track>) {
        self.mapper = mapper
    }
    
    func parse(from path: String) -> Track? {
        guard let data = try? Data(contentsOf: URL(filePath: path)) else { return nil }
        return mapper.map(item: data)
    }
}
