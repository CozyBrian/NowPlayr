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
        var hiding = hidingFunc()
        
        super.init(
            contentRect: NSRect(x: hiding.x, y: hiding.y, width: 370, height: 190),
            styleMask: [.borderless,.resizable,.closable,.fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.collectionBehavior = [.canJoinAllSpaces, .canJoinAllSpaces]
        self.level = .floating
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true

        self.backgroundColor = .clear
        self.isMovableByWindowBackground = false
        self.isReleasedWhenClosed = false

        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
    }
    
    func updatePosition(_ to: CGPoint) {
//        self.setFrameOrigin(to)
        let fittingSize = contentView?.fittingSize ?? .zero
        self.setFrame(.init(origin: to, size: fittingSize), display: true, animate: true)
    }
}
