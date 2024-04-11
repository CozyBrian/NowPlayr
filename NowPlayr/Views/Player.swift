//
//  Player.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct Player: View {
    @EnvironmentObject var playerManager: PlayerManager
    
    private weak var parentWindow: FloatingPlayerWindow!
    
    init(parentWindow: FloatingPlayerWindow) {
        self.parentWindow = parentWindow
    }
    
    var body: some View {
        // Expanded
        VStack {
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
                Image("artwork")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
                    .clipped()
                    .blur(radius: 2)
                    .mask {
                        Image(systemName: "waveform")
                            .imageScale(.large)
                            .symbolRenderingMode(.hierarchical)
                    }
                    .scaleEffect(1.2, anchor: .trailing)
            }
            .padding(.top, 22)
            .padding(.horizontal, 22)
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                Text("0:34")
                    .frame(width: 36, alignment: .leading)
                    .clipped()
                    .foregroundColor(.white.opacity(0.5))
                ZStack(alignment: .leading) {
                    Capsule(style: .continuous)
                        .fill(.white.opacity(0.33))
                    Rectangle()
                        .fill(.white)
                        .frame(width: 33)
                        .clipped()
                }
                .frame(height: 7)
                .clipped()
                .mask { RoundedRectangle(cornerRadius: 6, style: .continuous) }
                Text("-3:30")
                    .frame(width: 36, alignment: .trailing)
                    .clipped()
                    .foregroundColor(.white.opacity(0.5))
            }
            .font(.caption2)
            .padding(.horizontal, 24)
            HStack {
                Image(systemName: "airplayaudio")
                    .imageScale(.medium)
                    .opacity(0)
                Image(systemName: "backward.fill")
                    .imageScale(.medium)
                    .frame(maxWidth: .infinity)
                    .clipped()
                Image(systemName: "play.fill")
                    .imageScale(.large)
                    .font(.title2)
                Image(systemName: "forward.fill")
                    .imageScale(.medium)
                    .frame(maxWidth: .infinity)
                    .clipped()
                Image(systemName: "airplayaudio")
                    .imageScale(.medium)
                    .foregroundColor(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .clipped()
            .padding(.horizontal, 32)
            .padding(.vertical)
            .font(.title2)
            Spacer()
        }
        .frame(width: 370, height: 200)
        .clipped()
        .foregroundColor(.white)
        .background(.black)
        .mask { RoundedRectangle(cornerRadius: 44, style: .continuous) }
    }
}

#Preview {
    Player(parentWindow: FloatingPlayerWindow()).environmentObject(PlayerManager())
}
