//
//  MediaRemote.swift
//  NowPlayr
//
//  Created by Brian Newton on 13/04/2024.
//

import Cocoa
import MediaPlayer

let bundle = CFBundleCreate(kCFAllocatorDefault, NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MediaRemote.framework"))

let MRMediaRemoteRegisterForNowPlayingNotificationsPointer = CFBundleGetFunctionPointerForName(
    bundle, "MRMediaRemoteRegisterForNowPlayingNotifications" as CFString
)
typealias MRMediaRemoteRegisterForNowPlayingNotificationsFunction = @convention(c) (DispatchQueue) -> Void
let MRMediaRemoteRegisterForNowPlayingNotifications = unsafeBitCast(MRMediaRemoteRegisterForNowPlayingNotificationsPointer, to: MRMediaRemoteRegisterForNowPlayingNotificationsFunction.self)

let MRMediaRemoteGetNowPlayingInfoPointer = CFBundleGetFunctionPointerForName(
    bundle, "MRMediaRemoteGetNowPlayingInfo" as CFString)
typealias MRMediaRemoteGetNowPlayingInfoFunction = @convention(c) (DispatchQueue, @escaping ([String: Any]) -> Void) -> Void
let MRMediaRemoteGetNowPlayingInfo = unsafeBitCast(
    MRMediaRemoteGetNowPlayingInfoPointer, to: MRMediaRemoteGetNowPlayingInfoFunction.self
)

struct nowPlayingInfo {
    static let artist = "kMRMediaRemoteNowPlayingInfoArtist"
    static let title = "kMRMediaRemoteNowPlayingInfoTitle"
    static let album = "kMRMediaRemoteNowPlayingInfoAlbum"
    static let duration = "kMRMediaRemoteNowPlayingInfoDuration"
    static let elapsedTime = "kMRMediaRemoteNowPlayingInfoElapsedTime"
    static let timestamp = "kMRMediaRemoteNowPlayingInfoTimestamp"
    static let artworkData = "kMRMediaRemoteNowPlayingInfoArtworkData"
}
