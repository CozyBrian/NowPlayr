//
//  PlayingDuration.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct PlayingDuration: View {
    @EnvironmentObject var playerManager: PlayerManager
    @State var sliderConfig: SliderConfig = .init()
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3) {
            Text(playerManager.formattedPlaybackPosition)
                .frame(width: 36, alignment: .leading)
                .clipped()
                .foregroundColor(.white.opacity(0.5))
            CustomSlider(
                cornerRadius: 6,
                stroke: 7,
                strokeOffset: 1.5,
                config: $sliderConfig,
                onEndedDragging: { value in self.playerManager.seekTrackFromValue(value) }
            )
            .onAppear(perform: {
                sliderConfig.progress = (playerManager.seekerPosition / playerManager.trackDuration)
                sliderConfig.lastProgress = (playerManager.seekerPosition / playerManager.trackDuration)
            })
            .onChange(of: playerManager.seekerPosition, perform: { value in
                sliderConfig.progress = (playerManager.seekerPosition / playerManager.trackDuration)
                sliderConfig.lastProgress = (playerManager.seekerPosition / playerManager.trackDuration)
            })
            Text(playerManager.formattedDuration)
                .frame(width: 36, alignment: .trailing)
                .clipped()
                .foregroundColor(.white.opacity(0.5))
        }
        .font(.caption2)
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
}

#Preview {
    PlayingDuration().environmentObject(PlayerManager()).frame(width: 400)
}
