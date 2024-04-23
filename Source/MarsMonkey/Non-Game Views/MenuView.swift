
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
        ZStack {
            // Background color
            Color(.mmUIBackground)
                .ignoresSafeArea()
            
            VStack{
                // Game title
                StrokeText(text: "Mars Monkey", strokeWidth: 1)
                    .font(Font.custom("RedBurger", size: 55))
                    .foregroundColor(.white)
                
                HStack {
                    // Text field to input user name
                    TextField("Enter your name", text: $playerName)
                        .background{
                            Rectangle()
                                .foregroundColor(.mmPinkButton)
                                .cornerRadius(10)
                                .frame(width: 340, height: 100, alignment: .center)
                        }
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
                }
                .ignoresSafeArea(.keyboard)
                
                // Logo
                Image(.monkeyOnMarsPlanet)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(CGPoint(x: 180, y: 180))
                
                // Play button
                roundedButton(title: "Play", action: {
                    // Present warning if player name is empty
                    if playerName != ""{
                        withAnimation { self.currentGameState = .playing }
                    } else{
                        withAnimation { isWarningPresented = true }
                    }
                })
                
                // Leaderboard button
                roundedButton(title: "Leaderboard", action: {
                    withAnimation { self.currentGameState = .leaderboard }
                })
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Input user name warning
            if isWarningPresented{
                ZStack{
                    Color(.black)
                        .padding(.all, -100)
                        .ignoresSafeArea()
                        .opacity(0.3)
                    
                    VStack{
                        Spacer()
                        
                        StrokeText(text: "Please, enter your name", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                        
                        Spacer()
                        
                        roundedButton(title: "Okay", fontSize: 24, action: {
                            withAnimation { isWarningPresented = false }
                        })
                        .padding()
                    }
                    .frame(maxHeight: 200)
                    .background(.mmPink)
                    .cornerRadius(10)
                }
                .padding()
            }

        }
        .onTapGesture {
            isFocused=false
        }
    }
}

#Preview {
    MenuView(currentGameState: .constant(GameState.menu))
}
