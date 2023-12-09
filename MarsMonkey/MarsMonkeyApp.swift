//
//  MarsMonkeyApp.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

@main
struct MarsMonkeyApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
                .preferredColorScheme(.light)
        }
    }
}
