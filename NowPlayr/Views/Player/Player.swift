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
            AlbumInfoView()
            PlayingDuration()
            BottomControls()
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
