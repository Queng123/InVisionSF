//
//  EventDetailsOverlay.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI
import MapKit
import QuickLook

struct EventDetailOverlay: View {
    let event: Event
    let onClose: () -> Void
    var selectedEvent: Event?

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State private var isVideoPlaying = false
    @State private var selectedVideoName: String? = nil
    @State private var showingBuyView = false

    @State private var lookaroundScene: MKLookAroundScene?
    

    init(event: Event, onClose: @escaping () -> Void) {
            self.event = event
            self.onClose = onClose
        }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }
            
            VStack {
                VStack {
                    VStack{
                        Text(event.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        
                        if !event.location.isEmpty {
                            Text("Location: \(event.location)")
                                .font(.headline)
                                .padding(.bottom, 2)
                        }
                        
                        if !event.date.isEmpty {
                            Text("Date: \(event.date)")
                                .font(.subheadline)
                                .padding(.bottom, 10)
                        }
                        
                        Text(event.description)
                            .font(.body)
                            .padding()
                        if !event.ticketInfo.isEmpty {
                            Button(action: {
                                showingBuyView = true
                            }) {
                                Text("More informations here!")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .sheet(isPresented: $showingBuyView) {
                                BuyTicketView(ticketInfos: event.ticketInfo)
                            }
                        }
                    }
                    .padding()
                    VStack{
                        if let lookaroundScene {
                            LookAroundPreview(initialScene: lookaroundScene)
                                .frame( width: 400, height: 200)
                                .padding()
                        } else {
                            ContentUnavailableView("No preview available", systemImage: "eye.slash")
                        }
                        Button(action: {
                            if let url = URL(string: "./Ressources/" + event.spacialVideoLink) {
                                let fileName = url.deletingPathExtension().lastPathComponent
                                let fileExtension = url.pathExtension
                                
                                if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
                                    let previewItem = PreviewItem(url: fileURL, displayName: event.title, editingMode: .disabled)
                                    _ = PreviewApplication.open(items: [previewItem])
                                } else {
                                    print("Could not find file: \(event.spacialVideoLink)")
                                }
                            }
                        }) {
                            Text("Play spatial video")
                                .font(.headline)
                                .frame(width: 200, height: 25)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                    }
                }
                .frame(width: 1000, height: 800)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(15)
                .shadow(radius: 10)
                Button(action: onClose) {
                    Text("Close")
                        .font(.headline)
                        .frame(width: 100, height: 25)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
            }
            .task {
                await fetchLookaroundPreview()
            }
        }
    }
    
    func fetchLookaroundPreview() async {
        lookaroundScene = nil
        if let coordinates = event.mapInfo?.coordinates {
            let lookaroundRequest = MKLookAroundSceneRequest(coordinate: coordinates)
            do {
                lookaroundScene = try await lookaroundRequest.scene
            } catch {
                print("Error fetching LookAround scene: \(error)")
            }
        }
    }
}
