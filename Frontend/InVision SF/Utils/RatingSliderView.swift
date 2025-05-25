//
//  RatingSliderView.swift
//  InVision SF
//
//  Created by Quentin Brejoin on 5/25/25.
//

import SwiftUI

struct RatingSlider: View {
    @Binding var currentRating: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Rating: \(Int(currentRating))/10")
                .font(.headline)
                .foregroundColor(.primary)
            
            Slider(value: $currentRating, in: 0...10, step: 1) {
                Text("Rating")
            } minimumValueLabel: {
                Text("0")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } maximumValueLabel: {
                Text("10")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .accentColor(.blue)
            
            HStack {
                ForEach(0...10, id: \.self) { value in
                    Text("\(value)")
                        .font(.system(size: 12))
                        .foregroundColor(value <= Int(currentRating) ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        .hoverEffect(.highlight)
    }
}
