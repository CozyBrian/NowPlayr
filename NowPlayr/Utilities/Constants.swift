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
    
    enum Sections {
        enum `left` {
            static var showing: CGPoint {
                let mainScreen = NSScreen.screens[0]
                let screen = mainScreen.frame.size
                return .init(x: 0, y: screen.height - (24 + 200))
            }
            
            static var hiding: CGPoint {
                let mainScreen = NSScreen.screens[0]
                let screen = mainScreen.frame.size
                return .init(x: 0, y: screen.height)
            }
        }
        
        enum center {
            static var showing: CGPoint {
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
        }
        
        enum `right` {
            static var showing: CGPoint {
                let mainScreen = NSScreen.screens[0]
                let screen = mainScreen.frame.size
                let end = screen.width - (370 + 24)
                return .init(x: end, y: screen.height - (24 + 200))
            }
            
            static var hiding: CGPoint {
                let mainScreen = NSScreen.screens[0]
                let screen = mainScreen.frame.size
                let end = screen.width
                return .init(x: end, y: screen.height - (24 + 200))
            }
        }
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
