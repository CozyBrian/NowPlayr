//
//  SupportedApps.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import Foundation
import SwiftUI

enum ConnectedApps: String, Equatable, CaseIterable {
    case spotify = "Spotify"
    case appleMusic = "Apple Music"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
