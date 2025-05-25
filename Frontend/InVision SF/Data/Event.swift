//
//  Event.swift
//  AppleVision-SF
//
//  Created by Tom Backert on 26.11.24.
//
import Foundation
import MapKit
import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []

    func fetchEvents() {
        events = EventData.allEvents()
    }
}


class Event: Identifiable, Hashable, ObservableObject {
    let id = UUID()
    let title: String
    let location: String
    let description: String
    let ticketLink: String
    let date: String
    let spacialVideoLink: String
    var rating: Double
    var my_rating: Double
    let mapInfo: MapInfo?
    let ticketInfo: [TicketInfo]

    struct MapInfo {
        let imageMarker: String
        let colorMarker: Color
        let coordinates: CLLocationCoordinate2D
    }
    
    init(title: String, location: String, description: String, ticketLink: String, date: String, spacialVideoLink: String, mapInfo: MapInfo? = nil, ticketInfo: [TicketInfo] = [], rating: Double, my_rating: Double = 0.0) {
        self.title = title
        self.location = location
        self.description = description
        self.ticketLink = ticketLink
        self.date = date
        self.spacialVideoLink = spacialVideoLink
        self.mapInfo = mapInfo
        self.ticketInfo = ticketInfo
        self.rating = rating
        self.my_rating = my_rating
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func updateRating(rating: Double) {
        my_rating = rating
    }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}
