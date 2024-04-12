//
//  StatusbarItemManager.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

class StatusBarItemManager: ObservableObject {
    @AppStorage("connectedApp") var connectedApp: ConnectedApps = ConnectedApps.spotify
    
    public func getMenuBarView(track: Track, playerAppIsRunning: Bool, isPlaying: Bool) -> NSView {
        let image = self.getImage(albumArt: track.albumArt, playerAppIsRunning: playerAppIsRunning)
        
        let menuBarIconView = ZStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(nsImage: image)
            }
        }
        
        let menuBarView = NSHostingView(rootView: menuBarIconView)
        menuBarView.frame = NSRect(x: 0, y: 1, width: 20, height: 20)
        
        return menuBarView
    }
    
    // MARK: - Private

    private func getImage(albumArt: NSImage, playerAppIsRunning: Bool) -> NSImage {
        if playerAppIsRunning {
            return albumArt.roundImage(withSize: NSSize(width: 18, height: 18), radius: 4.0)
        }
        
        return NSImage(systemSymbolName: "play.fill", accessibilityDescription: "NowPlayer")!
    }
}
