//
//  UserDefaults+Extension.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import Foundation
import AppKit
import SwiftUI
import Combine

extension UserDefaults {
    @objc dynamic var connectedApp: String {
        return string(forKey: "connectedApp")!
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func onValueChanged<T: Equatable>(of value: T, perform onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }

}

extension NSImage {
    func isEmpty() -> Bool {
        guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil),
              let dataProvider = cgImage.dataProvider else { return true }
        let pixelData = dataProvider.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let imageWidth = Int(self.size.width)
        let imageHeight = Int(self.size.height)
        for x in 0..<imageWidth {
            for y in 0..<imageHeight {
                let pixelIndex = ((imageWidth * y) + x) * 4
                let r = data[pixelIndex]
                let g = data[pixelIndex + 1]
                let b = data[pixelIndex + 2]
                let a = data[pixelIndex + 3]
                if a != 0 {
                    if r != 0 || g != 0 || b != 0 { return false }
                }
            }
        }
        return true
    }
    
    func roundImage(withSize imageSize: NSSize, radius: CGFloat) -> NSImage {
        let imageFrame = NSRect(origin: .zero, size: imageSize)

        let newImage = NSImage(size: imageSize)
        newImage.lockFocus()
        NSGraphicsContext.saveGraphicsState()

        let path = NSBezierPath(roundedRect: imageFrame, xRadius: radius, yRadius: radius)
        path.addClip()

        self.size = imageFrame.size
        self.draw(in: imageFrame, from: NSZeroRect, operation: NSCompositingOperation.sourceOver, fraction: 1.0, respectFlipped: true, hints: nil)

        NSGraphicsContext.restoreGraphicsState()

        newImage.unlockFocus()

        return newImage
    }
}

extension Notification.Name {
    static let spotifyPlayerStateDidChange = Notification.Name(
        "com.spotify.client.PlaybackStateChanged"
    )
}

extension Double {
    func asTimeString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}

extension BinaryFloatingPoint {
    func asTimeString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(self)) ?? ""
    }
}

extension DateComponentsFormatter {
    static let playbackTimeWithHours: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    static let playbackTime: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
}


struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({_ in onPress()})
                    .onEnded({_ in onRelease()})
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: { onPress() }, onRelease: { onRelease() }))
    }
}


struct ScaleButtonStyle : ButtonStyle {
    @State private var isPressing: Bool = false
    let action: () -> Void
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressing ? 0.9 : 1)
            .modifier(ButtonPress(onPress: {
                
                withAnimation(.easeInOut(duration: 0.15)) {
                    action()
                    isPressing = true
                }
                }, onRelease: {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        isPressing = false
                    }
                }))
    }
}

extension ButtonStyle where Self == ScaleButtonStyle {
    static var scaleButton: Self { .init {
        
    } }
}


struct VisualEffectView: NSViewRepresentable
{
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView
    {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }

    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
    {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
