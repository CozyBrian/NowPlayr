//
//  AboutSettingsView.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("NowPlayr")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Version \(Constants.AppInfo.appVersion ?? "?")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Divider()
                HStack {
                    Link("GitHub", destination: URL(string: "https://github.com/CozyBrian/NowPlayr")!)
                        .buttonStyle(.bordered)
                    Link("Website", destination: URL(string: "https://briannewton.dev/NowPlayr")!)
                        .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 24)
        }.frame(width: 320)
    }
}

#Preview {
    AboutSettingsView()
}
