//
//  StrokeText.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 22/04/24.
//

import SwiftUI

// This structure is used to create a text with stroke
struct StrokeText: View {
    let text: String
    let strokeWidth: CGFloat

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  strokeWidth, y:  strokeWidth)
                Text(text).offset(x: -strokeWidth, y: -strokeWidth)
                Text(text).offset(x: -strokeWidth, y:  strokeWidth)
                Text(text).offset(x:  strokeWidth, y: -strokeWidth)
            }
            .foregroundColor(.black)
            Text(text)
        }
    }
}

#Preview {
    StrokeText(text: "Test", strokeWidth: 2.0)
}
