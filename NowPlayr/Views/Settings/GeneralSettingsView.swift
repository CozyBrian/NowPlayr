//
//  GeneralSettingsView.swift
//  NowPlayr
//
//  Created by Brian Newton on 12/04/2024.
//

import SwiftUI
import Settings
import LaunchAtLogin

struct GeneralSettingsView: View {
    @AppStorage("connectedApp") private var connectedAppAppStorage = ConnectedApps.spotify
    
    @State private var alertTitle = Text("Title")
    @State private var alertMessage = Text("Message")
    @State private var showingAlert = false
    @State private var connectedApp: ConnectedApps
    
    init() {
        @AppStorage("connectedApp") var connectedAppAppStorage = ConnectedApps.spotify
        self.connectedApp = connectedAppAppStorage
    }
    
    var body: some View {
        VStack {
            Form(content: {
                Section(content: {
                    LaunchAtLogin.Toggle()
                })
                Section("Connect NowPlayr to", content: {
                    HStack(content: {
                        Picker(selection: $connectedApp, content: {
                            ForEach(ConnectedApps.allCases, id: \.self) { value in
                                Text(value.localizedName).tag(value)
                            }
                        }, label: {
                        }).onChange(of: connectedApp) { _ in
                            self.connectedAppAppStorage = connectedApp
                        }
                        .pickerStyle(.segmented)
                        
                        Button {
                            let consent = Helper.promptUserForConsent(for: connectedApp == .spotify ? Constants.Spotify.bundleID : Constants.AppleMusic.bundleID)
                            switch consent {
                            case .closed:
                                alertTitle = Text("\(Text(connectedApp.localizedName)) is not open")
                                alertMessage = Text("Please open \(Text(connectedApp.localizedName)) to enable permissions")
                            case .granted:
                                alertTitle = Text("Permission granted for \(Text(connectedApp.localizedName))")
                                alertMessage = Text("Start playing a song!")
                            case .notPrompted:
                                return
                            case .denied:
                                alertTitle = Text("Permission denied")
                                alertMessage = Text("Please go to System Settings > Privacy & Security > Automation, and check \(Text(connectedApp.localizedName)) under Tuneful")
                            }
                            showingAlert = true
                        } label: {
                            Image(systemName: "person.fill.questionmark")
                        }
                        .buttonStyle(.borderless)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: alertTitle, message: alertMessage, dismissButton: .default(Text("Got it!")))
                        }
                    })
                })
            

            })
            .formStyle(.grouped)
            
            
        }.frame(width: 320)
    }
}

#Preview {
    GeneralSettingsView()
}
