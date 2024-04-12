//
//  AppDelegate.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/14/23.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    private var initSetupHasRun: Bool = false
    @AppStorage("showPlayerWindow") var showPlayerWindow: Bool = false
    @AppStorage("viewedOnboarding") var viewedOnboarding: Bool = false
    @AppStorage("viewedShortcutsSetup") var viewedShortcutsSetup: Bool = false
    @AppStorage("miniPlayerWindowOnTop") var miniPlayerWindowOnTop: Bool = true
    @AppStorage("connectedApp") var connectedApp = ConnectedApps.spotify
    
    var popover = NSPopover.init()
    var statusBar: StatusBarController?
    
    // Windows
    private var floatingPlayerWindow: FloatingPlayerWindow = FloatingPlayerWindow()
    private var onboardingWindow: OnboardingWindow!
    
    // Managers
    private var playerManager: PlayerManager!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        self.playerManager = PlayerManager()
        
        if !viewedOnboarding {
            self.showOnboarding()
        } else {
            self.mainSetup()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    private func mainSetup() {
        self.setupPopoverWindow()
        self.setupFloatingPlayer()
//        self.setupKeyboardShortcuts()
    }
    
    // MARK: - FLOATING WINDOW
    
    @objc func setupFloatingPlayer() {
        let windowPosition = Constants.hiding
        
        setupFloatingPlayerWindow(
            size: NSSize(width: 370, height: 190),
            position: windowPosition,
            view: Player(parentWindow: floatingPlayerWindow)
        )
    
        
        floatingPlayerWindow.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        playerManager.timerStartSignal.send()
        
        if !showPlayerWindow {
            if initSetupHasRun {
                playerManager.timerStopSignal.send()
            }
            floatingPlayerWindow.close()
        }
        initSetupHasRun = true
    }
    
    @objc func showFloatingPlayerWindow(_ sender: AnyObject) {
        self.floatingPlayerWindow.makeKeyAndOrderFront(nil)
        playerManager.timerStartSignal.send()
        self.floatingPlayerWindow.updatePosition(Constants.showingCenter)
    }
    
    @objc func hideFloatingPlayerWindow(_ sender: AnyObject) {
        self.floatingPlayerWindow.updatePosition(Constants.hiding)
        self.playerManager.timerStopSignal.send()
        self.floatingPlayerWindow.close()
    }
    
    private func setupFloatingPlayerWindow<Content: View>(size: NSSize, position: CGPoint, view: Content) {
        DispatchQueue.main.async {
            self.floatingPlayerWindow.setFrame(NSRect(origin: position, size: size), display: true, animate: true)
        }
        
        let rootView = view.cornerRadius(15).environmentObject(self.playerManager)
        let hostedOnboardingView = NSHostingView(rootView: rootView)
        floatingPlayerWindow.contentView = hostedOnboardingView
    }
    
    
    // MARK: - POPOVER WINDOW
    @objc func setupPopoverWindow() {
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()

        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.contentViewController = NSHostingController(rootView: contentView)
        
        // Create the Status Bar Item with the above Popover
        statusBar = StatusBarController.init(popover)
        
    }
    
    // MARK: - Setup
    
    public func showOnboarding() {
        if onboardingWindow == nil {
            onboardingWindow = OnboardingWindow()
            let rootView = OnboardingView()
            let hostedOnboardingView = NSHostingView(rootView: rootView)
            onboardingWindow.contentView = hostedOnboardingView
        }
        
        onboardingWindow.center()
        onboardingWindow.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    @objc func finishOnboarding(_ sender: AnyObject) {
        onboardingWindow.close()
        self.mainSetup()
    }
}
