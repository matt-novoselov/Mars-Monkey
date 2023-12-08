//
//  ContentView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Matt!")
            Text("Mars Monkey")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
