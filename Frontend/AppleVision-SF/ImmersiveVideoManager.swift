//
//  ImmersiveVideoManager.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 4/6/25.
//


import Foundation
import Observation

@Observable
class ImmersiveVideoManager {
    static let shared = ImmersiveVideoManager()

    var selectedVideo: String?

    private init() {}
}

