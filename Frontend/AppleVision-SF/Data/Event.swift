//
//  Event.swift
//  AppleVision-SF
//
//  Created by Tom Backert on 26.11.24.
//
import Foundation
import MapKit
import SwiftUI

struct Event: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let location: String
    let description: String
    let ticketLink: String
    let date: String
    let spacialVideoLink: String
    let mapInfo: MapInfo?

    struct MapInfo {
        let imageMarker: String
        let colorMarker: Color
        let coordinates: CLLocationCoordinate2D
    }
    
    init(title: String, location: String, description: String, ticketLink: String, date: String, spacialVideoLink: String, mapInfo: MapInfo? = nil) {
        self.title = title
        self.location = location
        self.description = description
        self.ticketLink = ticketLink
        self.date = date
        self.spacialVideoLink = spacialVideoLink
        self.mapInfo = mapInfo
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}
