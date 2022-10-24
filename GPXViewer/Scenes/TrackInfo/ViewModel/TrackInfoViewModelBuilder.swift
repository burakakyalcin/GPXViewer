//
//  TrackInfoViewModelBuilder.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 23/10/2022.
//

import Foundation

struct TrackInfoViewModelBuilder {
    static func build(with track: Track) -> TrackInfoViewModel {
        var items: [TrackInfoTableViewCellViewModel] = []
        
        if let startDate = track.trackDetails.first?.time {
            items.append(TrackInfoTableViewCellViewModel(name: "Started at", description: createStringFromDate(startDate)))
        }
        
        if let endDate = track.trackDetails.last?.time {
            items.append(TrackInfoTableViewCellViewModel(name: "Ended at", description: createStringFromDate(endDate)))
        }
        
        let trackDetailCount = Double(track.trackDetails.count)
        
        let azimuthList = track.trackDetails.compactMap { Double($0.azimuth ?? "0") }
        let averageAzimuth = azimuthList.reduce(0.0, +) / trackDetailCount
        let averageAzimuthString = String(format: "%g", averageAzimuth)
        items.append(TrackInfoTableViewCellViewModel(name: "Average azimuth", description: averageAzimuthString))
        
        let averageSpeedList = track.trackDetails.compactMap { Double($0.speedInKnots ?? "0") }
        let averageSpeed = averageSpeedList.reduce(0.0, +) / trackDetailCount
        let averageSpeedString = String(format: "%g", averageSpeed)
        items.append(TrackInfoTableViewCellViewModel(name: "Average speed in knots", description: averageSpeedString))
        
        let averageHorizontalAccuracyList = track.trackDetails.compactMap { Double($0.horizontalAccuracy ?? "0") }
        let averageHorizontalAccuracy = averageHorizontalAccuracyList.reduce(0.0, +) / trackDetailCount
        let averageHorizontalAccuracyString = String(format: "%g", averageHorizontalAccuracy)
        items.append(TrackInfoTableViewCellViewModel(name: "Average horizontal accuracy", description: averageHorizontalAccuracyString))
        
        let averageTicksList = track.trackDetails.compactMap { Double($0.ticks ?? "0") }
        let averageTicks = averageTicksList.reduce(0.0, +) / trackDetailCount
        let averageTicksString = String(format: "%g", averageTicks)
        items.append(TrackInfoTableViewCellViewModel(name: "Average ticks", description: averageTicksString))
        
        return TrackInfoViewModel(items: items)
    }
    
    private static func createStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        return dateFormatter.string(from: date)
    }
}
