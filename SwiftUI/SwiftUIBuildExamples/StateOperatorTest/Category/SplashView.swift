//
//  SplashView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI

struct SplashView: View {
    
    @State var isAppStartAvailable: AppState = .splashViewLoading
    
    @StateObject var provider = ServiceProvider()
    
    var body: some View {
        VStack {
            switch isAppStartAvailable {
            case .splashViewLoading:
                Text("Awesome Splash View")
            case .noNetwork:
                NoNetworkView()
            case .jailBreak:
                WaringJailBreakView()
            case .safe:
                HomeView()
                    .environmentObject(provider)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    
                    guard checkJailBreak() == nil else {
                        isAppStartAvailable = .jailBreak
                        return
                    }
                    
                    isAppStartAvailable = .safe
                }
            }
        }
    }
}

extension SplashView {
    
    enum AppState {
        case splashViewLoading
        case noNetwork
        case jailBreak
        case safe
    }

    private func checkJailBreak() -> AppState? {
        
        print(access("/Applications/Cydia.app", F_OK) != -1)
        
        if access("/Applications/Cydia.app", F_OK) != -1
            || access("/Applications/blackra1n.app", F_OK) != -1
            || access("/Applications/FakeCarrier.app", F_OK) != -1
            || access("/Applications/Icy.app", F_OK) != -1
            || access("/Applications/IntelliScreen.app", F_OK) != -1
            || access("/Applications/MxTube.app", F_OK) != -1
            || access("/Applications/RockApp.app", F_OK) != -1
            || access("/Applications/SBSettings.app", F_OK) != -1
            || access("/Applications/WinterBoard.app", F_OK) != -1
            || access("/Library/MobileSubstrate/MobileSubstrate.dylib", F_OK) != -1
            || access("/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist", F_OK) != -1
            || access("/Library/MobileSubstrate/DynamicLibraries/Veency.plist", F_OK) != -1
            || access("/private/var/lib/apt", F_OK) != -1
            || access("/private/var/lib/cydia", F_OK) != -1
            || access("/private/var/mobile/Library/SBSettings/Themes", F_OK) != -1
            || access("/private/var/stash", F_OK) != -1
            || access("/private/var/tmp/cydia.log", F_OK) != -1
            || access("/System/Library/LaunchDaemons/com.ikey.bbot.plist", F_OK) != -1
            || access("/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist", F_OK) != -1 {
//            || access("/usr/bin/sshd", F_OK) != -1
//            || access("/usr/libexec/sftp-server", F_OK) != -1
//            || access("/usr/sbin/sshd", F_OK) != -1
//            || access("/bin/bash", F_OK) != -1
//            || access("/etc/apt", F_OK) != -1 {
            return .jailBreak
        }
        
        return nil
    }
    
}
