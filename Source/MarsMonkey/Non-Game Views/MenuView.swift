
//  MenuView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 09.12.2023.


import SwiftUI

// Main game menu View
struct MenuView: View {
    
    // Current game state, which can be menu, playing, timeIsUp, leaderboard
    @Binding var currentGameState: GameState
    
    // Saved player nave for user defaults
    @AppStorage("savedPlayerName") var savedPlayerName: String = ""
    
    // Inputted player name
    @State var playerName: String = ""
    
    // Overlay sheet that is present when the user hasn't inputted the name before the start of the game
    @State var isWarningPresented: Bool = false
    
    // Bool that checks if the keyboard is shown
    @FocusState var isFocused : Bool
    
    var body: some View {
        
        VStack{
            // Game title
            StrokeText(text: "Mars Monkey", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 55))
                .foregroundColor(.white)
            
            HStack {
                // Text field to input user name
                TextField("Enter your name", text: $playerName)
                    .focused($isFocused)
                    .frame(width: 300)
                    .font(Font.custom("RedBurger", size: 30))
                    .foregroundColor(.black)
                
                // Open keyboard on tap
                    .onTapGesture {
                        isFocused = true
                    }
                
                // Save new player name when edit is finished
                    .onChange(of: playerName){
                        savedPlayerName = playerName
                    }
                
                // Extract saved user name and put it to the field
                    .onAppear(){
                        playerName = savedPlayerName
                    }
                    .ignoresSafeArea(.keyboard)
            }
            .padding()
            .background{
                Color.mmPinkButton
                    .cornerRadius(10)
                
            }
            
            // Logo
            Image(.monkeyOnMarsPlanet)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            // Play button
            RoundedButton(title: "Play", action: {
                // Present warning if player name is empty
                if !playerName.isEmpty {
                    withAnimation { self.currentGameState = .playing }
                } else{
                    withAnimation { isWarningPresented = true }
                }
            })
            
            // Leaderboard button
            RoundedButton(title: "Leaderboard", action: {
                withAnimation { self.currentGameState = .leaderboard }
            })
            
            // Leaderboard button
            RoundedButton(title: "Credits", action: {
                withAnimation { self.currentGameState = .credits }
            })
        }
        .padding(.horizontal)
        .background(.mmUIBackground)
        .overlay{
            if isWarningPresented{
                PlayerNameWarning(isWarningPresented: $isWarningPresented)
            }
        }
        
        // Un focus text field on tap
        .onTapGesture {
            isFocused=false
        }
        
    }
}

#Preview {
    MenuView(currentGameState: .constant(GameState.menu))
}
