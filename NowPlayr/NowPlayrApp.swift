//
//  NowPlayrApp.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/14/23.
//

import SwiftUI

@main
struct NowPlayrApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
