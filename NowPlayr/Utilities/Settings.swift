//
//  Settings.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import Cocoa
import Settings

extension Settings.PaneIdentifier {
    static let general = Self("general")
    static let appearance = Self("appearance")
    static let about = Self("about")
}

public extension SettingsWindowController {
  override func keyDown(with event: NSEvent) {
    if event.modifierFlags.intersection(.deviceIndependentFlagsMask) == .command, let key = event.charactersIgnoringModifiers {
      if key == "w" {
        self.close()
      }
    }
  }
}


let GeneralSettingsViewController: () -> SettingsPane = {
    let paneView = Settings.Pane(
        identifier: .general,
        title: "General",
        toolbarIcon: NSImage(systemSymbolName: "gear", accessibilityDescription: "General settings")!
    ) {
        GeneralSettingsView()
    }
    
    return Settings.PaneHostingController(pane: paneView)
}

let AppearanceSettingsViewController: () -> SettingsPane = {
    let paneView = Settings.Pane(
        identifier: .appearance,
        title: "Appearance",
        toolbarIcon: NSImage(systemSymbolName: "sun.min", accessibilityDescription: "Appearance settings")!
    ) {
        AppearanceSettingsView()
    }
    
    return Settings.PaneHostingController(pane: paneView)
}

let AboutSettingsViewController: () -> SettingsPane = {
    let paneView = Settings.Pane(
        identifier: .about,
        title: "About",
        toolbarIcon: NSImage(systemSymbolName: "info.circle", accessibilityDescription: "About settings")!
    ) {
        AboutSettingsView()
    }
    
    return Settings.PaneHostingController(pane: paneView)
}
