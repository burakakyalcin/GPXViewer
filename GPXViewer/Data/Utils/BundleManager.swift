//
//  BundleManager.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 21/10/2022.
//

import Foundation

final class BundleManager {
    static func fetchResourcePaths(for resourceName: String, resourceType: String, inDirectory directory: String) -> [String] {
        guard let resourcesBundlePath = Bundle.main.path(forResource: resourceName, ofType: "bundle") else { return [] }
        let resourcesBundle = Bundle(path: resourcesBundlePath)
        guard let resourcePaths = resourcesBundle?.paths(forResourcesOfType: resourceType, inDirectory: directory).sorted() else { return [] }
        return resourcePaths
    }
}
