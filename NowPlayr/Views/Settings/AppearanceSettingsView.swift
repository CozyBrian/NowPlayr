//
//  AppearanceSettingsView.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI

struct AppearanceSettingsView: View {
    @AppStorage("miniPlayerType") var appearanceTypeAppStorage: AppearanceType = .nowPlaying
    @AppStorage("playerPlacement") var playerPlacementAppStorage: PlacementType = .center
    @AppStorage("playerShowDuration") var playerShowDurationAppStorage: Int = 4
    
    @State var appearanceType: AppearanceType
    @State var playerShowDuration: Int
    @State var playerPlacement: PlacementType
    
    init() {
        @AppStorage("miniPlayerType") var appearanceTypeAppStorage: AppearanceType = .nowPlaying
        @AppStorage("playerPlacement") var playerPlacementAppStorage: PlacementType = .center
        @AppStorage("playerShowDuration") var playerShowDurationAppStorage: Int = 4

        self.appearanceType = appearanceTypeAppStorage
        self.playerShowDuration = playerShowDurationAppStorage
        self.playerPlacement = playerPlacementAppStorage
    }
    
    var body: some View {
        VStack {
            Form(content: {
                Section(content: {
                    Picker("Set Appearance", selection: $appearanceType) {
                        ForEach(AppearanceType.allCases, id: \.self) { value in
                            Text(value.localizedName).tag(value)
                        }
                    }
                    .onChange(of: appearanceType) {
                        self.appearanceTypeAppStorage = appearanceType
                        NSApplication.shared.sendAction(#selector(AppDelegate.hideFloatingPlayerWindow), to: nil, from: nil)
                        NSApplication.shared.sendAction(#selector(AppDelegate.resetFloatingPlayerWindow), to: nil, from: nil)
                    }
                    .pickerStyle(.menu)
                 
                })
                
                Section(content: {
                    Picker("Show Player Duration", selection: $playerShowDuration) {
                        ForEach(3..<16, id: \.self) { value in
                                Text("\(value) sec").tag(value)
                            }
                        }
                    .onChange(of: playerShowDuration) {
                        self.playerShowDurationAppStorage = playerShowDuration
                    }
                    .pickerStyle(.menu)
                })
                
                Section(content: {
                    Picker("Player Placement", selection: $playerPlacement) {
                        ForEach(PlacementType.allCases, id: \.self) { value in
                            Text(value.localizedName).tag(value)
                        }
                    }
                    .onChange(of: playerPlacement) {
                        self.playerPlacementAppStorage = playerPlacement
                        NSApplication.shared.sendAction(#selector(AppDelegate.resetFloatingPlayerPos), to: nil, from: nil)
                    }
                    .pickerStyle(.menu)
                })
            })
            .formStyle(.grouped)
        }.frame(width: 320)
    }
}

#Preview {
    AppearanceSettingsView()
}
