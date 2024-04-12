//
//  AppDelegate.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/14/23.
//

import Cocoa
import SwiftUI
import Settings

class AppDelegate: NSObject, NSApplicationDelegate {

    private var initSetupHasRun: Bool = false
    @AppStorage("showPlayerWindow") var showPlayerWindow: Bool = false
    @AppStorage("viewedOnboarding") var viewedOnboarding: Bool = false
    @AppStorage("viewedShortcutsSetup") var viewedShortcutsSetup: Bool = false
    @AppStorage("miniPlayerType") var appearanceType: AppearanceType = .nowPlaying
    @AppStorage("connectedApp") var connectedApp = ConnectedApps.spotify
    
//    var popover = NSPopover.init()
//    var statusBar: StatusBarController?
    
    // Windows
    private var floatingPlayerWindow: FloatingPlayerWindow = FloatingPlayerWindow()
    private var onboardingWindow: OnboardingWindow!
    private var popover: NSPopover!
    
    // Status bar
    private var statusBarItem: NSStatusItem!
    public var statusBarMenu: NSMenu!
    
    // Managers
    private var playerManager: PlayerManager!
    private var statusBarItemManager: StatusBarItemManager!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        self.playerManager = PlayerManager()
        self.statusBarItemManager = StatusBarItemManager()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateStatusBarItem),
            name: NSNotification.Name("UpdateMenuBarItem"),
            object: nil
        )
        
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
        self.setupMenuBar()
        self.updateStatusBarItem(nil)
        //        self.setupKeyboardShortcuts()
    }
    
    // MARK: - FLOATING WINDOW
    
    @objc func setupFloatingPlayer() {
        let windowPosition = hidingFunc()
        
        switch appearanceType {
        case .player:
            setupFloatingPlayerWindow(
                size: NSSize(width: 370, height: 190),
                position: windowPosition,
                view: Player(parentWindow: floatingPlayerWindow)
            )
        case .nowPlaying:
            setupFloatingPlayerWindow(
                size: NSSize(width: 329, height: 155),
                position: windowPosition,
                view: NowPlaying(parentWindow: floatingPlayerWindow)
            )
        }
        
        
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
    
    @objc func resetFloatingPlayerWindow() {
        self.setupFloatingPlayer()
    }
    
    @objc func resetFloatingPlayerPos() {
        let windowPosition = hidingFunc()
        self.floatingPlayerWindow.updatePosition(windowPosition)
    }
    
    
    @objc func showFloatingPlayerWindow(_ sender: AnyObject) {
        let windowPosition = showingFunc()
        
        self.floatingPlayerWindow.makeKeyAndOrderFront(nil)
        playerManager.timerStartSignal.send()
        self.floatingPlayerWindow.updatePosition(windowPosition)
        self.showPlayerWindow = true
    }
    
    @objc func hideFloatingPlayerWindow(_ sender: AnyObject) {
        let windowPosition = hidingFunc()
        
        self.floatingPlayerWindow.updatePosition(windowPosition)
        self.playerManager.timerStopSignal.send()
        self.floatingPlayerWindow.close()
        self.showPlayerWindow = false
    }
    
    private func setupFloatingPlayerWindow<Content: View>(size: NSSize, position: CGPoint, view: Content) {
        DispatchQueue.main.async {
            self.floatingPlayerWindow.setFrame(NSRect(origin: position, size: size), display: true, animate: true)
        }
        
        let rootView = view.cornerRadius(15).environmentObject(self.playerManager)
        let hostedOnboardingView = NSHostingView(rootView: rootView)
        floatingPlayerWindow.contentView = hostedOnboardingView
    }
    
    // MARK: - Menu bar
    
    @objc func updateStatusBarItem(_ notification: NSNotification?) {
        guard viewedOnboarding else { return }
        
        var playerAppIsRunning = playerManager.isRunning
        if notification?.userInfo?["PlayerAppIsRunning"] != nil {
            playerAppIsRunning = notification?.userInfo?["PlayerAppIsRunning"] as? Bool == true
        }
        
        let menuBarView = self.statusBarItemManager.getMenuBarView(
            track: playerManager.track,
            playerAppIsRunning: playerAppIsRunning,
            isPlaying: playerManager.isPlaying
        )
        
        if let button = self.statusBarItem.button {
            button.subviews.forEach { $0.removeFromSuperview() }
            button.addSubview(menuBarView)
            button.frame = menuBarView.frame
        }
        
    }
    
    private func setupMenuBar() {
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        statusBarMenu = NSMenu()
//        statusBarMenu.delegate = self
        
        statusBarMenu.addItem(
            withTitle: "Show mini player",
            action: #selector(showHideMiniPlayer),
            keyEquivalent: ""
        )
        .state = showPlayerWindow ? .on : .off
                
        statusBarMenu.addItem(.separator())
        
        statusBarMenu.addItem(
            withTitle: "Settings...",
            action: #selector(openSettings),
            keyEquivalent: ""
        )
        
//        let updates = NSMenuItem(
//            title: "Check for updates...",
//            action: #selector(SUUpdater.checkForUpdates(_:)),
//            keyEquivalent: ""
//        )
//        updates.target = SUUpdater.shared()
//        statusBarMenu.addItem(updates)
        
        statusBarMenu.addItem(.separator())
        
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(NSApplication.terminate),
            keyEquivalent: ""
        )
        
        if let statusBarItemButton = statusBarItem.button {
            statusBarItemButton.action = #selector(didClickStatusBarItem)
            statusBarItemButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    
    @objc func didClickStatusBarItem(_ sender: AnyObject?) {
        guard let event = NSApp.currentEvent else { return }
        
        switch event.type {
        case .rightMouseUp:
            statusBarItem.menu = statusBarMenu
            statusBarItem.button?.performClick(nil)
        default:
            statusBarItem.menu = statusBarMenu
            statusBarItem.button?.performClick(nil)
        }
    }
    
    @objc func toggleMiniPlayer() {
        self.showHideMiniPlayer(self.statusBarMenu.item(withTitle: "Show mini player")!)
    }
    
    @IBAction func showHideMiniPlayer(_ sender: NSMenuItem) {
        if sender.state == .on {
            sender.state = .off
            self.hideFloatingPlayerWindow(sender)
        } else {
            sender.state = .on
            self.showFloatingPlayerWindow(sender)
        }
    }
    
    @IBAction func openURL(_ sender: AnyObject) {
        let url = URL(string: "https://github.com/CozyBrian/NowPlayr")
        NSWorkspace.shared.open(url!)
    }
    
    func menuDidClose(_: NSMenu) {
        statusBarItem.menu = nil
    }
    
    
    // MARK: - POPOVER WINDOW
    @objc func setupPopoverWindow() {
        let frameSize = NSSize(width: 350, height: 200)
        
        let rootView = ContentView()
            .environmentObject(self.playerManager)
        let hostedContentView = NSHostingView(rootView: rootView)
        hostedContentView.frame = NSRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        popover = NSPopover()
        popover.contentSize = frameSize
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = hostedContentView
        popover.contentViewController?.view.window?.makeKey()
        
        playerManager.popoverIsShown = popover.isShown
//        // Create the SwiftUI view that provides the contents
//        let contentView = ContentView()
//
//        // Set the SwiftUI's ContentView to the Popover's ContentViewController
//        popover.contentSize = NSSize(width: 360, height: 360)
//        popover.contentViewController = NSHostingController(rootView: contentView)
//        
//        // Create the Status Bar Item with the above Popover
//        statusBar = StatusBarController.init(popover)
    }
    
    @objc func showPopover(_ sender: NSStatusBarButton?) {
        guard let statusBarItemButton = sender else { return }
        
        popover.show(relativeTo: statusBarItemButton.bounds, of: statusBarItemButton, preferredEdge: .minY)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    @objc func openSettings(_ sender: AnyObject) {
        SettingsWindowController(
            panes: [
                GeneralSettingsViewController(),
                AppearanceSettingsViewController(),
                AboutSettingsViewController()
            ],
            style: .toolbarItems,
            animated: true,
            hidesToolbarForSingleItem: true
        ).show()
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
