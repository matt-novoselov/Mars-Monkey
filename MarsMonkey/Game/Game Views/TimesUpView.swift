//
//  TimesUpView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI
import SwiftData

struct TimesUpView: View {
    @AppStorage("savedPlayerName") var savedPlayerName: String = ""
    @Binding var currentGameState: GameState
    
    @State var amountOfBananasPlanted: Int = 0
    
    @State var TopPlayerName: String = "Top player"
    @State var TopPlayerScore: String = "999"
    
    @Environment(\.modelContext) private var context
    @Query private var items: [MyDataItem]
    
    var body: some View {
        ZStack{
            Image(.marsBackground)
                .frame(maxWidth: 0)
            
            VStack{                
                if TopPlayerScore != "0"{
                    TopPlayerCard(TopPlayerName: TopPlayerName, TopPlayerScore: TopPlayerScore)
                    .onAppear(){
                        TopPlayerName = ordinatedItems(items: items).first?.name ?? "No name"
                        
                        TopPlayerScore = ordinatedItems(items: items).first?.score ?? "0"
                    }
                }
                
                VStack(spacing: 20){
                    StrokeText(text: "Time’s up!", strokeWidth: 1)
                        .font(Font.custom("RedBurger", size: 48))
                        .foregroundColor(.white)
                    
                    Image(.timesUpMonkey)
                    
                    if amountOfBananasPlanted>0{
                        StrokeText(text: "Congrats on planting \(amountOfBananasPlanted) banana tree\(amountOfBananasPlanted>1 ? "s" : "")", strokeWidth: 1)
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
        .onAppear(){
            amountOfBananasPlanted = GameLogic.shared.currentScore
            
            let requestResult = addAndCheckItem(playerName: savedPlayerName, score: String(amountOfBananasPlanted), items: items)
            
            if requestResult.name == "nil" && requestResult.score == "nil" {
                try? context.save()
            }
            else{
                context.insert(requestResult)
            }
        }
    }
}

#Preview {
    TimesUpView(currentGameState: .constant(GameState.timeIsUp))
        .modelContainer(for: MyDataItem.self)
}
