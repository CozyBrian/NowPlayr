//
//  NowPlaying.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct NowPlaying: View {
    @EnvironmentObject var playerManager: PlayerManager
    
    private weak var parentWindow: FloatingPlayerWindow!
    
    init(parentWindow: FloatingPlayerWindow) {
        self.parentWindow = parentWindow
    }
    
    var body: some View {

        HStack(alignment: .top, spacing: 12) {
            Image(nsImage: playerManager.track.albumArt)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                }
            VStack(alignment: .leading, spacing: 3) {
                Spacer()
                Text(playerManager.isPlaying ? "NOW PLAYING" : "PAUSED")
                    .font(.system(.caption2, weight: .semibold))
                    .opacity(0.5)
                Text(playerManager.track.title)
                    .font(.system(.subheadline, weight: .semibold))
                Text(playerManager.track.artist)
                    .font(.system(.subheadline, weight: .medium))
                    .opacity(0.9)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
            .padding(.bottom, 4)
            Image(systemName: "infinity")
                .imageScale(.medium)
                .foregroundColor(.white)
                .font(.system(.callout, weight: .medium))
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .padding()
        .background {
            ZStack {
                Image(nsImage: playerManager.track.albumArt)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.5, anchor: .center)
                    .blur(radius: 0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .blur(radius: 36, opaque: true)
            }
            .background(.black.opacity(0.9))
        }
        .frame(width: 329 ,height: 155)


    }
}

#Preview {
    NowPlaying(parentWindow: FloatingPlayerWindow()).environmentObject(PlayerManager())
}
