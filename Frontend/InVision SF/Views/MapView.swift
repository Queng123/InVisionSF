//
//  MapView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 11/26/24.

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: EventViewModel
    @Binding var selectedEvent: Event?

    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    )
    
    @State private var isShowingUserView = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Map(position: $region, selection: $selectedEvent) {
                ForEach(viewModel.events) { event in
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
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    isShowingUserView = true
                }) {
                    Image(systemName: "list.bullet.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 40) // Adjust size as needed
                        .foregroundColor(.white)
                        .padding(20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 45)
                        .fill(Color.blue.opacity(0.8))
                )
            
                VStack(alignment: .leading, spacing: 8) {
                    Text("Legend")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 12, height: 12)
                        Text("Events")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 12, height: 12)
                        Text("Landmarks")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                        Text("Restaurants")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                .padding(12)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            .padding(.top, 40)
            .padding(.leading, 20)
            
        }
        .sheet(isPresented: $isShowingUserView) {
            UserView()
        }
    }
}
