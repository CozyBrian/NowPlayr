//
//  SliderView.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct SliderView: View {
    @State var playerPaused = true
    @State var volumeConfig: SliderConfig = .init()
    @Namespace private var namespace
    
    var body: some View {
        CustomSlider(
            cornerRadius: 6,
            stroke: 7,
            strokeOffset: 1.5,
            config: $volumeConfig,
            onEndedDragging: nil
        )
    }
}

struct CustomSlider: View {
    var cornerRadius: CGFloat = 18
    var stroke: CGFloat = 64
    var strokeOffset: CGFloat = 5
    @Binding var config: SliderConfig
    let onEndedDragging: ((CGFloat) -> Void)?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                Rectangle()
                    .fill(.white.opacity(0.33))
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(.white)
                            .scaleEffect(x: config.progress, anchor: .leading)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            }
            .frame(height: config.isDragging ? stroke + strokeOffset : stroke)
            .gesture(
                LongPressGesture(minimumDuration: 0.3).onEnded({ _ in
                    print("pressed")
                }).simultaneously(with: DragGesture().onChanged({ value in
                    withAnimation(.easeIn(duration: 0.1), {
                        config.isDragging = true
                    })
                    
                    if !config.shrink {
                        let startLocation = value.startLocation.x
                        let currentLocation = value.location.x
                        let offset = -(startLocation - currentLocation)
                        
                        var progress = (offset / size.width) + config.lastProgress
                        progress = max(0, progress)
                        progress = min(1, progress)
                        config.progress = progress
                    }
                }).onEnded({ value in
                    withAnimation(.easeOut(duration: 0.1), {
                        config.isDragging = false
                    })
                    config.lastProgress = config.progress
                    self.onEndedDragging?(config.progress)
                }))
            )
        }.frame(height: config.isDragging ? stroke + strokeOffset : stroke)
    }
}

#Preview {
    SliderView()
        .padding(.all, 24)
        .frame(width: 300)
}
