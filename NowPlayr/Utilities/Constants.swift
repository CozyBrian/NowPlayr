//
//  File.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI
import AppKit

enum Constants {
    static var showingCenter: CGPoint {
        let mainScreen = NSScreen.screens[0]
        let screen = mainScreen.frame.size
        let center = (screen.width / 2) - 185
        return .init(x: center, y: screen.height - (24 + 200))
    }
    
    static var hiding: CGPoint {
        let mainScreen = NSScreen.screens[0]
        let screen = mainScreen.frame.size
        let center = (screen.width / 2) - 185
        return .init(x: center, y: screen.height)
    }
    
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
