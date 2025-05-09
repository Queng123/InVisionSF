//
//  ContentView.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI
import RealityKit
import MapKit

struct ContentView: View {
    @State private var searchText = ""
    @State private var isMenuExpanded = false
    @State private var events: [Event] = []
    @State private var selectedEvent: Event? = nil
    @StateObject private var userCart = UserCart()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    MapView(events: $events, selectedEvent: $selectedEvent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)

                    ExpandableMenu(
                        isExpanded: $isMenuExpanded,
                        searchText: $searchText,
                        events: $events,
                        onEventSelected: { event in
                            selectedEvent = event
                        }
                    )
                }

                if let selectedEvent = selectedEvent {
                    EventDetailOverlay(event: selectedEvent) {
                        self.selectedEvent = nil
                    }
                }
            }
            .onAppear {
                fetchEvents()
                print(events)
            }
        }
        .environmentObject(userCart)
    }

    private func fetchEvents() {
        events = EventData.allEvents()
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
