//
//  OnboardingView.swift
//  NowPlayr
//
//  Created by Brian Newton on 11/04/2024.
//

import SwiftUI

struct OnboardingView: View {
    private enum Steps {
      case onAppPicker, onDetails, onShortcuts
    }
    
    @AppStorage("viewedShortcutsSetup") var viewedShortcutsSetup: Bool = false
    
    @State private var step: Steps = .onAppPicker
    @State private var finishedAlert = false
    
    var body: some View {

        
        VStack {
            VStack(spacing: 8) {
                Text("Onboarding")
                    .font(.title2)
                    .fontWeight(.semibold)
                if step == .onAppPicker {
                    Text("1. Preferred Music App")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else if step == .onDetails {
                    Text("2. Permssions")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else if step == .onShortcuts {
                    Text("3. Global Keyboard Shortcuts")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } else {
                    EmptyView()
                }
            }
            VStack(alignment: .center) {
                VStack {
                    VStack {
                        Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)

                    }
                    .padding(.bottom, 20)
                    
                    if step == .onAppPicker {
                        AppPicker()
                    } else if step == .onDetails {
                        Details(finishedAlert: $finishedAlert)
                    } else if step == .onShortcuts {
                        Shortcuts()
                    } else {
                        EmptyView()
                    }
                }
                .frame(width: 200, height: 250)
                .padding(.horizontal, 32)
                .animation(.spring(), value: step)
                
                Divider()
                
                HStack {
                    if step == .onDetails {
                        Button("Back") {
                            step = .onAppPicker
                        }
                    } else if step == .onShortcuts {
                        Button("Back") {
                            step = .onDetails
                        }
                    } else {
                        Button("Back") {
                            step = .onAppPicker
                        }
                        .disabled(step == .onAppPicker)
                    }
                    
                    if step == .onAppPicker {
                        Button("Continue") {
                            step = .onDetails
                        }
                        .keyboardShortcut(.defaultAction)
                    } else if step == .onDetails {
                        Button("Continue") {
                            step = .onShortcuts
                        }
                        .keyboardShortcut(.defaultAction)
                        .disabled(!finishedAlert)
                    } else {
                        Button("Finish") {
                            self.viewedShortcutsSetup = true
                            NSApplication.shared.sendAction(#selector(AppDelegate.finishOnboarding), to: nil, from: nil)
                        }
                    }
                }
                .frame(width: 150, height: 50)
            }
            .frame(width: 250, height: 300)
            
        }
        .padding(.all, 32)
        .frame(maxWidth: 300)
        
        .edgesIgnoringSafeArea(.all)
    }
}


struct AppPicker: View {
    
    @AppStorage("connectedApp") private var connectedApp = ConnectedApps.spotify
    
    var body: some View {
        VStack(spacing: 10) {
            Picker("", selection: $connectedApp) {
                ForEach(ConnectedApps.allCases, id: \.self) { value in
                    Text(value.localizedName).tag(value)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct Details: View {
    
    @AppStorage("viewedOnboarding") var viewedOnboarding: Bool = false
    @AppStorage("connectedApp") private var connectedApp = ConnectedApps.spotify
    
    @Binding var finishedAlert: Bool
    
    @State private var alertTitle = Text("Title")
    @State private var alertMessage = Text("Message")
    @State private var showAlert = false
    @State private var success = false
    
    private var name: Text {
        Text(connectedApp.localizedName)
    }
    
    var body: some View {
        VStack {
            Text("""
                 NowPlayr requires permission to control \(name) and display music data.
                 
                 Open \(name) and click 'Enable permissions' below and select OK in the alert that is presented.
             """)
            .font(.caption)
            .multilineTextAlignment(.center)
            
            Button("Enable permissions") {
                let consent = Helper.promptUserForConsent(for: connectedApp == .spotify ? Constants.Spotify.bundleID : Constants.AppleMusic.bundleID)
                switch consent {
                case .granted:
                    alertTitle = Text("You are all set up!")
                    alertMessage = Text("Start playing a song!")
                    success = true
                    showAlert = true
                    viewedOnboarding = true
                case .closed:
                    alertTitle = Text("\(name) is not open")
                    alertMessage = Text("Please open \(name) to enable permissions")
                    showAlert = true
                    success = false
                case .denied:
                    alertTitle = Text("Permission denied")
                    alertMessage = Text("Please go to System Settings > Privacy & Security > Automation, and check \(name) under NowPlayr")
                    showAlert = true
                    success = false
                case .notPrompted:
                    return
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: alertTitle, message: alertMessage, dismissButton: .default(Text("Got it!")) {
                    if success {
                        finishedAlert = true
                    }
                })
            }
        }
    }
}

struct Shortcuts: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, content: {
                Form {
//                    KeyboardShortcuts.Recorder("Play/pause:", name: .playPause)
//                    KeyboardShortcuts.Recorder("Next track:", name: .nextTrack)
//                    KeyboardShortcuts.Recorder("Next track:", name: .previousTrack)
//                    KeyboardShortcuts.Recorder("Toggle mini player:", name: .showMiniPlayer)
//                    KeyboardShortcuts.Recorder("Switch music player:", name: .changeMusicPlayer)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text("You can always change these later")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
            })
            .padding(.horizontal, 50)
        }
        .padding(.bottom, 40)
    }
}


#Preview {
    OnboardingView()
}
