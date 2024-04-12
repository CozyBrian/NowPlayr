//
//  AlbumInfoView.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct AlbumInfoView: View {
    @EnvironmentObject var playerManager: PlayerManager
    
    var body: some View {
        HStack(spacing: 16) {
            // Album Art
            Image(nsImage: playerManager.track.albumArt)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 66, height: 66)
                .clipped()
                .mask { RoundedRectangle(cornerRadius: 14, style: .continuous) }
            VStack(alignment: .leading) {
                Text(playerManager.track.title)
                    .font(.system(.body, weight: .semibold))
                Text(playerManager.track.artist)
                    .font(.system(.body, weight: .regular))
                    .foregroundColor(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
            // Waveform
            Image(systemName: "waveform")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24)
                .clipped()
                .symbolEffect(
                    .variableColor,
                    value: playerManager.isPlaying
                )
                
        }
        .padding(.top, 22)
        .padding(.horizontal, 22)
    }
}

#Preview {
    Player(parentWindow: FloatingPlayerWindow()).environmentObject(PlayerManager())
}
