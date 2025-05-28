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
    @State private var currentRating: Double
    @State private var went: Bool

    @State private var lookaroundScene: MKLookAroundScene?
    

    init(event: Event, onClose: @escaping () -> Void) {
            self.event = event
            self.onClose = onClose
            self._currentRating = State(initialValue: event.my_rating)
            self._went = State(initialValue: event.went)
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
                        
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: starType(for: index, rating: event.rating))
                                    .foregroundColor(.yellow)
                                    .font(.largeTitle)
                                    .overlay(
                                        Image(systemName: "star")
                                            .foregroundColor(.black)
                                            .font(.largeTitle)
                                    )
                            }

                            Text(String(format: "%.1f", event.rating))
                                .font(.largeTitle)
                        }
                        .padding(.bottom, 10)
                        
                        if went {
                            RatingSlider(currentRating: $currentRating)
                                .padding(.horizontal)
                                .onChange(of: currentRating) { oldValue, newValue in
                                    event.updateRating(rating: newValue)
                                }
                        }
                        
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
                                BuyTicketView(ticketInfos: event.ticketInfo, eventName: event.title)
                            }.buttonStyle(PlainButtonStyle())
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
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            went.toggle()
                            event.went = went
                        }) {
                            Text(went ? "I didn't go to this event" : "I went to this event")
                                .font(.headline)
                                .frame(width: 200, height: 25)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())
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
                .buttonStyle(PlainButtonStyle())
                
            }
            .task {
                await fetchLookaroundPreview()
            }
        }
    }

    private func starType(for index: Int, rating: Double) -> String {
        let starValue = Double(index)
        
        if rating >= starValue {
            return "star.fill"
        } else if rating >= starValue - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
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
