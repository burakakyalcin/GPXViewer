//
//  MapSnapshotGenerator.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import MapKit

enum SnapshotGeneratorError: Error {
    case invalidRegion
}

struct MapSnapshotGenerator {
    static func generateSnapshot(from coordinates: [CLLocationCoordinate2D], completion: @escaping (Result<UIImage, Error>) -> Void) throws {
        let options = MKMapSnapshotter.Options()
        guard let region = MKCoordinateRegion(coordinates: coordinates) else { throw SnapshotGeneratorError.invalidRegion }
        options.region = region
        
        let snapshotter = MKMapSnapshotter(options: options)
        
        snapshotter.start { snapshot, error in
           if let snapshot = snapshot {
               let snapshotWithLines = drawLineOnImage(coordinates: coordinates, snapshot: snapshot)
               completion(.success(snapshotWithLines))
           } else if let error = error {
               completion(.failure(error))
           }
        }
    }
    
    static func drawLineOnImage(coordinates: [CLLocationCoordinate2D], snapshot: MKMapSnapshotter.Snapshot) -> UIImage {
        let image = snapshot.image

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 256, height: 256), true, 0)
        image.draw(at: CGPoint.zero)

        guard let context = UIGraphicsGetCurrentContext() else { return snapshot.image }

        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.move(to: snapshot.point(for: coordinates[0]))
        
        for i in 0...coordinates.count - 1 {
          context.addLine(to: snapshot.point(for: coordinates[i]))
          context.move(to: snapshot.point(for: coordinates[i]))
        }

        context.strokePath()

        guard let resultImage = UIGraphicsGetImageFromCurrentImageContext() else { return snapshot.image }

        UIGraphicsEndImageContext()

        return resultImage
    }
}
