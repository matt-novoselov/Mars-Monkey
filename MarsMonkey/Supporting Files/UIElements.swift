//
//  UIElements.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

// This structure is used to create a round button with a custom action
struct roundedButton: View {
    var title: String
    var fontSize: CGFloat = 40
    var action: () -> Void
    
    var body: some View {
        Button(action: {action(); lightHaptic()}){
            StrokeText(text: title, strokeWidth: 1)
                .font(Font.custom("RedBurger", size: fontSize))
                .foregroundColor(.mmPink)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(.mmPinkButton)
                .cornerRadius(90)
        }
        .buttonStyle(PressEffectButtonStyle())
    }
}

// This structure is used to create an animation for buttons
struct PressEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

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

// This structure is used for displaying single user in leaderboard
struct leaderboardParticipant: View {
    var playerName: String = "Player Name"
    var playerScore: Int = 0
    var place: Int = 0
    var isHighlighted: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .padding(.horizontal, -50)
                .ignoresSafeArea()
                .frame(height: 65)
                .foregroundColor(.white)
                .opacity(isHighlighted ? 1 : 0)
            
            HStack(spacing: 10){
                Group{
                    StrokeText(text: place.description, strokeWidth: 1)
                        .frame(width: 30, alignment: .leading)
                                    
                    StrokeText(text: playerName, strokeWidth: 1)
                    
                    Spacer()
                    
                    Image(.palmTree)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                    
                    StrokeText(text: playerScore.description, strokeWidth: 1)
                        .frame(alignment: .trailing)
                }
                .foregroundColor(.mmLightPinkTitle)
                .font(Font.custom("RedBurger", size: 20))
            }
        }
    }
}

//This structure is used to format and create game timer
struct GameTimer: View {
    var secondsLeft: Int

    var body: some View {
        StrokeText(text: "\(secondsLeft/60):\(secondsLeft%60)", strokeWidth: 1)
            .font(Font.custom("RedBurger", size: 48))
            .foregroundColor(.mmPink)
    }
}

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
                .foregroundColor(.mmPink)
        }
    }
}

#Preview{
    VStack{
        roundedButton(title: "Play", action: {})
        
        leaderboardParticipant(isHighlighted: true)
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.mmUIBackground)
}
