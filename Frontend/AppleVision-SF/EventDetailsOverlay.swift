//
//  EventDetailsOverlay.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI
import MapKit
import AVKit
import RealityKit

import QuickLook

struct EventDetailOverlay: View {
    let event: Event
    let onClose: () -> Void
    var selectedEvent: Event?

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State private var isVideoPlaying = false
    @State private var videoPlayer: AVPlayer?
    @State private var selectedVideoName: String? = nil

    @State private var lookaroundScene: MKLookAroundScene?
    

    init(event: Event, onClose: @escaping () -> Void) {
            self.event = event
            self.onClose = onClose
            //print("Event Details: \(event)")
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
                        
                        
                        Text("Location: \(event.location)")
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        Text("Date: \(event.date)")
                            .font(.subheadline)
                            .padding(.bottom, 10)
                        
                        Text(event.description)
                            .font(.body)
                            .padding()
                        Button(action: {
                            if let url = URL(string: event.ticketLink) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Text("Buy tickets here!")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                    }
                    .padding()
                    VStack{
                        // Street View
                        if let lookaroundScene {
                            LookAroundPreview(initialScene: lookaroundScene)
                                .frame( width: 400, height: 200)
                                .padding()
                        } else {
                            ContentUnavailableView("No preview available", systemImage: "eye.slash")
                        }
                        Button(action: {
                            ImmersiveVideoManager.shared.selectedVideo = event.spacialVideoLink
                            Task {
                                do {
                                    print("🎯 Attempting to open immersive space")
                                    try await openImmersiveSpace(id: "videoImmersive")
                                    print("✅ Immersive space opened")
                                } catch {
                                    print("❌ Error opening immersive space: \(error)")
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
                    .onDisappear {
                       // Stop video when the view disappears
                       videoPlayer?.pause()
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

struct PlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
