//
//  NowPlaying.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct NowPlaying: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("artwork")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                }
            VStack(alignment: .leading, spacing: 3) {
                Spacer()
                Text("NOW PLAYING")
                    .font(.system(.caption2, weight: .semibold))
                    .opacity(0.5)
                Text("Need to Know")
                    .font(.system(.subheadline, weight: .semibold))
                Text("Doja Cat")
                    .font(.system(.subheadline, weight: .medium))
                    .opacity(0.9)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
            .padding(.bottom, 4)
            Image(systemName: "infinity")
                .imageScale(.medium)
                .foregroundColor(.white)
                .font(.system(.callout, weight: .medium))
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .padding()
        .background {
            Image("artwork")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.3, anchor: .center)
                .blur(radius: 36)
                .overlay {
                    Rectangle()
                        .fill(.clear)
                        .background(Material.ultraThin)
                        .opacity(0.25)
                }
        }.frame(width: 350 ,height: 170)
    }
}

#Preview {
    NowPlaying()
}
