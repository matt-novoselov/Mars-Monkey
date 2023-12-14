//
//  MarsMonkeyApp.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI
import SwiftData
import AVFoundation

@main
struct MarsMonkeyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .statusBar(hidden: true)
                .persistentSystemOverlays(.hidden)
        }
        .modelContainer(for: MyDataItem.self)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var gameLogic = GameLogic.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Start the music
        gameLogic.playBackgroundMusic()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Stop the music when the app is in background
        gameLogic.backgroundMusicPlayer?.pause()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Restart the music when the app is re-opened
        gameLogic.backgroundMusicPlayer?.play()
    }
}
