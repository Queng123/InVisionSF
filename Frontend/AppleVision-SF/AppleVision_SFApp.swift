//
//  AppleVision_SFApp.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI

@main
struct AppleVision_SFApp: App {
    @State private var videoManager = ImmersiveVideoManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.defaultSize(CGSize(width: 2000, height: 1500))
        
        ImmersiveSpace(id: "videoImmersive") {
            if let selected = videoManager.selectedVideo {
                ImmersiveVideoView(videoName: selected)
            }
        }
    }
}
