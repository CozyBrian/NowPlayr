//
//  SliderConfig.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import Foundation

// MARK: SLIDER CONFIG
struct SliderConfig {
    var shrink: Bool = false
    var expand: Bool = false
    var isDragging: Bool = false
    var progress: CGFloat = 0
    var lastProgress: CGFloat = 0
}
