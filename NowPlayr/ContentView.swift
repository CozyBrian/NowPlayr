//
//  ContentView.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/14/23.
//

import SwiftUI

struct ContentView: View {
    var liked = false
    var isPlaying = false
    var body: some View {
        VStack {
            // Now Playing
            VStack(spacing: 10) {
                HStack {
                    Image("artwork")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .clipped()
                        .mask {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                        }
                    VStack(alignment: .leading) {
                        Text("No More Parties In La")
                            .foregroundColor(.white)
                            .font(.system(.subheadline, weight: .medium))
                        Text("Kanye West")
                            .foregroundColor(.white.opacity(0.5))
                            .font(.subheadline)
                    }
                    .padding(.top, 3)
                    Spacer()
                }
                HStack {
                    Text("2:50")
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.opacity(0.33))
                        .frame(height: 4)
                        .clipped()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .frame(height: 4)
                                .clipped()
                                .padding(.trailing, 0)
                        }
                    Text("-0:51")
                }
                .foregroundColor(.white.opacity(0.75))
                .font(.caption2)
                HStack {
                    Image(systemName: "heart")
                        .imageScale(.medium)
                        .symbolRenderingMode(.monochrome)
                        .opacity(0.5)
                    Spacer()
                    HStack {
                        Image(systemName: "backward.fill")
                        Spacer()
                        Image(systemName: "pause.fill")
                            .font(.title)
                        Spacer()
                        Image(systemName: "forward.fill")
                    }
                    .frame(width: 160)
                    .clipped()
                    Spacer()
                    Image(systemName: "airpodspro")
                        .imageScale(.medium)
                        .symbolRenderingMode(.hierarchical)
                        .opacity(0.5)
                }
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .font(.title3)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.black.opacity(0.5))
            }
        }
        .frame(width: 350)
        .clipped()
        
    }
}

#Preview {
    ContentView()
}
