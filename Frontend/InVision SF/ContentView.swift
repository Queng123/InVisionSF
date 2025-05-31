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
    @StateObject private var viewModel = EventViewModel()
    @State private var selectedEvent: Event? = nil
    @StateObject private var user = User()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    MapView(viewModel: viewModel, selectedEvent: $selectedEvent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    ExpandableMenu(
                        isExpanded: $isMenuExpanded,
                        searchText: $searchText,
                        viewModel: viewModel,
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
                viewModel.fetchEvents()
                print(viewModel.events)
            }
        }
        .environmentObject(user)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
