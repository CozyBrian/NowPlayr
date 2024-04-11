//
//  OnboardingWindow.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import AppKit

class OnboardingWindow: NSWindow {
    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 400),
            styleMask: [.titled, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.titlebarAppearsTransparent = true
        self.isMovableByWindowBackground = true
        self.isReleasedWhenClosed = true
        self.level = .floating
    }
}
