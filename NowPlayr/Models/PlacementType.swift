//
//  PlacementType.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

enum PlacementType: String, Equatable, CaseIterable {
    
    case left = "left"
    case center = "center"
    case right = "right"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
