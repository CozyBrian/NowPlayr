//
//  AppearanceType.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

enum AppearanceType: String, Equatable, CaseIterable {
    
    case player = "player"
    case nowPlaying = "nowPlaying"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
