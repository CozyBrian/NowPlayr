//
//  FloatingPlayerWindow.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI
import AppKit

class FloatingPlayerWindow: NSWindow {
    
    init() {
        super.init(
            contentRect: NSRect(x: Constants.showingCenter.x, y: Constants.showingCenter.y, width: 350, height: 175),
            styleMask: [.borderless,.resizable,.closable,.fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.collectionBehavior = [.canJoinAllSpaces, .canJoinAllSpaces]
        self.level = .floating
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true

        self.backgroundColor = .clear
        self.isMovableByWindowBackground = true
        self.isReleasedWhenClosed = false

        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
    }
}
