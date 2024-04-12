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
            Button(action: {
            }, label: {
                Image(systemName: playerManager.isLoved ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .imageScale(.large)
                    .opacity(playerManager.isLoved ? 0.75 : 0.5)
                
            })
            .buttonStyle(ScaleButtonStyle(action: {
                playerManager.toggleLoveTrack()
            }))
            
            Spacer()
            HStack {
                Button {
                }label: {
                    Image(systemName: "backward.fill")
                        .imageScale(.large)
                }
                .buttonStyle(ScaleButtonStyle(action: {
                    playerManager.previousTrack()
                }))
                Spacer()
                Button {
                    playerManager.togglePlayPause()
                } label: {
                    Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .imageScale(.large)
                        .scaleEffect(1.05)
                        .contentTransition(.symbolEffect(.replace,options: .speed(1.9)))
                        
                }.buttonStyle(.borderless)
                
                Spacer()
                Button {
                }label: {
                    Image(systemName: "forward.fill")
                        .imageScale(.large)
                }
                .buttonStyle(ScaleButtonStyle(action: {
                    playerManager.nextTrack()
                }))
            }
            .frame(width: 160, height: 40)
            .clipped()
            Spacer()
            Button {
                print("airpods pressed")
            } label: {
                Image(systemName: "airpodspro")
                    .scaleEffect(1.1)
                    .symbolRenderingMode(.hierarchical)
                    .opacity(0.5)
                    .imageScale(.large)
            }
            .buttonStyle(.scaleButton)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 22)
        .font(.title3)
    }
}

#Preview {
    Player(parentWindow: FloatingPlayerWindow()).environmentObject(PlayerManager())
}
