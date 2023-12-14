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
                .foregroundColor(.white)
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
                .foregroundColor(isHighlighted ? .mmPink : .white)
                .font(Font.custom("RedBurger", size: 20))
            }
        }
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
                .foregroundColor(.white)
        }
    }
}

//This structure is used to create TopPlayerCard
struct TopPlayerCard: View {
    var TopPlayerName: String = "Top player"
    var TopPlayerScore: String = "0"

    var body: some View {
        HStack{
            Image(.crown).padding(.leading,5)
            StrokeText(text: TopPlayerName, strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 24))
                .foregroundColor(.white)
            
            HStack{
                Spacer()
                Image(.palmTree)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                StrokeText(text: TopPlayerScore, strokeWidth: 1)
                    .font(Font.custom("RedBurger", size: 24))
                    .foregroundColor(.white)
            }
            
        }
        .padding(.all, 10)
        .background(.mmPink)
        .cornerRadius(10)
        .frame(maxWidth: 312)
    }
}

#Preview{
    VStack{
        leaderboardParticipant(isHighlighted: true)
        
        leaderboardParticipant(isHighlighted: false)
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.mmUIBackground)
}
