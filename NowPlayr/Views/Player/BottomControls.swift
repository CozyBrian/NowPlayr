//
//  bottomControls.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct BottomControls: View {
    @EnvironmentObject var playerManager: PlayerManager
    
    var body: some View {
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
    }
}

#Preview {
    Player(parentWindow: FloatingPlayerWindow()).environmentObject(PlayerManager())
}
