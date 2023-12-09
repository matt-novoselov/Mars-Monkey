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
        Button(action: action){
            StrokeText(text: title, width: 1)
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
    let width: CGFloat

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
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
                    StrokeText(text: place.description, width: 1)
                        .frame(width: 30, alignment: .leading)
                                    
                    StrokeText(text: playerName, width: 1)
                    
                    Spacer()
                    
                    Image(.palmTree)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 35)
                    
                    StrokeText(text: playerScore.description, width: 1)
                        .frame(alignment: .trailing)
                }
                .foregroundColor(.mmLightPinkTitle)
                .font(Font.custom("RedBurger", size: 20))
            }
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
