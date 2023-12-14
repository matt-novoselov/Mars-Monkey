//
//  TimesUpView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

struct TimesUpView: View {
    
    @Binding var currentGameState: GameState
    
    var amountOfBananasPlanted: Int
    
    @State var TopPlayerName: String = "Top player"
    @State var TopPlayerScore: String = "999"
    
    var body: some View {
        ZStack{
            Image(.marsBackground)
                .frame(maxWidth: 0)
            
            VStack{
                if TopPlayerScore != "0"{
                    TopPlayerCard(TopPlayerName: TopPlayerName, TopPlayerScore: TopPlayerScore)
                    .onAppear(){
                        TopPlayerName = LeaderboardView(currentGameState: .constant(.leaderboard)).ordinatedItems().first?.name ?? "No name"
                        
                        TopPlayerScore = LeaderboardView(currentGameState: .constant(.leaderboard)).ordinatedItems().first?.score ?? "000"
                    }
                }
                
                VStack(spacing: 20){
                    StrokeText(text: "Time’s up!", strokeWidth: 1)
                        .font(Font.custom("RedBurger", size: 48))
                        .foregroundColor(.white)
                    
                    Image(.timesUpMonkey)
                    
                    if amountOfBananasPlanted>0{
                        StrokeText(text: "Congrats on planting \(amountOfBananasPlanted) banana trees", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    else{
                        StrokeText(text: "You did't plant any banana trees", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    roundedButton(title: "Menu", fontSize: 24, action: {
                        withAnimation { self.currentGameState = .menu }
                    })
                    
                    roundedButton(title: "Leaderboard", fontSize: 24, action: {
                        withAnimation { self.currentGameState = .leaderboard }
                    })
                }
                .padding()
                .background(.mmPink)
                .cornerRadius(10)
                .padding([.leading, .trailing, .bottom], 40)
            }
        }
    }
}

#Preview {
    TimesUpView(currentGameState: .constant(GameState.timeIsUp), amountOfBananasPlanted: 10)
}
