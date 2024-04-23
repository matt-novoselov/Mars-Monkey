//
//  GameScore.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 22/04/24.
//

import SwiftUI

//This structure is used to create game score
struct GameScore: View {
    var currentScore: Int

    var body: some View {
        HStack{
            Image(.palmTree)
                .resizable()
                .scaledToFit()
                .frame(height: 45)
            
            StrokeText(text: currentScore.description, strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 48))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    GameScore(currentScore: 100)
}
