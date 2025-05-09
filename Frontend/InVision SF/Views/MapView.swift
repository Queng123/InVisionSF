//
//  MapView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 11/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var events: [Event]
    @Binding var selectedEvent: Event?

    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    )

    var body: some View {
        Map(position: $region, selection: $selectedEvent) {
            ForEach(events) { event in
                if let mapInfo = event.mapInfo {
                        Marker(
                            event.title,
                            systemImage: mapInfo.imageMarker,
                            coordinate: mapInfo.coordinates
                        )
                        .tint(mapInfo.colorMarker)
                        .tag(event)
                    }
            }
        }
        
        
    }
    
}
