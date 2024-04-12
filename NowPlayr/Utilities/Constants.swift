//
//  File.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI
import AppKit

enum Constants {
    
    enum AppInfo {
        static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    enum Spotify {
        static let name = "Spotify"
        static let bundleID = "com.spotify.client"
        static let notification = "\(bundleID).PlaybackStateChanged"
    }
    
    enum AppleMusic {
        static let name = "Apple Music"
        static let bundleID = "com.apple.Music"
        static let notification = "\(bundleID).playerInfo"
    }
}


func showingFunc() -> CGPoint {
    @AppStorage("playerPlacement") var playerPlacement: PlacementType = .center
    @AppStorage("miniPlayerType") var appearanceType: AppearanceType = .nowPlaying
    
    let mainScreen = NSScreen.screens[0]
    let screen = mainScreen.frame.size
    
    switch appearanceType {
    case .player:
        switch playerPlacement {
        case .left:
            return .init(x: 0, y: screen.height - (24 + 200))
        case .center:
            let center = (screen.width / 2) - 185
            return .init(x: center, y: screen.height - (24 + 200))
        case .right:
            let end = screen.width - (370 + 24)
            return .init(x: end, y: screen.height - (24 + 200))
        }
    case .nowPlaying:
        switch playerPlacement {
        case .left:
            return .init(x: 0, y: screen.height - (18 + 24 + 155))
        case .center:
            let center = (screen.width / 2) - 165
            return .init(x: center, y: screen.height - (18 + 24 + 155))
        case .right:
            let end = screen.width - (329 + 20)
            return .init(x: end, y: screen.height - (18 + 24 + 155))
        }
    }
}

func hidingFunc() -> CGPoint {
    @AppStorage("playerPlacement") var playerPlacement: PlacementType = .center
    @AppStorage("miniPlayerType") var appearanceType: AppearanceType = .nowPlaying
    
    let mainScreen = NSScreen.screens[0]
    let screen = mainScreen.frame.size
    
    switch appearanceType {
    case .player:
        switch playerPlacement {
        case .left:
            return .init(x: 0, y: screen.height)
        case .center:
            let center = (screen.width / 2) - 185
            return .init(x: center, y: screen.height)
        case .right:
            let end = screen.width
            return .init(x: end, y: screen.height - (24 + 200))
        }
    case .nowPlaying:
        switch playerPlacement {
        case .left:
            return .init(x: 0, y: screen.height)
        case .center:
            let center = (screen.width / 2) - 165
            return .init(x: center, y: screen.height)
        case .right:
            let end = screen.width
            return .init(x: end, y: screen.height - (18 + 24 + 155))
        }
    }
}
