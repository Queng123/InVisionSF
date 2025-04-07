//
//  ImmersiveVideoView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 4/6/25.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ImmersiveVideoView: View {
    var videoName: String
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        RealityView { content in
            guard let url = Bundle.main.url(forResource: videoName, withExtension: "mov") else {
                print("Vidéo non trouvée")
                return
            }

            let player = AVPlayer(url: url)
            let material = VideoMaterial(avPlayer: player)

            let sphere = ModelEntity(mesh: .generateSphere(radius: 5))
            sphere.model?.materials = [material]
            sphere.scale = [-1, 1, 1] // Pour projeter à l’intérieur

            let anchor = AnchorEntity(world: .zero)
            anchor.addChild(sphere)
            content.add(anchor)

            player.play()
        } update: { content in
            // Si besoin d'update le contenu
        }
        .overlay(alignment: .topTrailing) {
            Button("Fermer") {
                Task {
                    await dismissImmersiveSpace()
                }
            }
            .padding()
            .background(Color.white.opacity(0.7))
            .cornerRadius(8)
        }.onAppear {
            print("ImmersiveVideoView apparue avec la vidéo: \(videoName)")
        }
    }
}
