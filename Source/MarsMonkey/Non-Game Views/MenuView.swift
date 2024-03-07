
//  MenuView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 09.12.2023.


import SwiftUI

struct MenuView: View {
    
    @Binding var currentGameState: GameState
    
    @AppStorage("savedPlayerName") var savedPlayerName: String = ""
    @State var playerName: String = ""
    @State var isWarningPresented: Bool = false
    
    @FocusState var isFocused : Bool // Bool that checks if the keyboard is shown
    
    var body: some View {
        ZStack {
            Color(.mmUIBackground)
                .ignoresSafeArea()
            
            VStack{
                StrokeText(text: "Mars Monkey", strokeWidth: 1)
                    .font(Font.custom("RedBurger", size: 55))
                    .foregroundColor(.white)
                
                HStack {
                    TextField("Enter your name", text: $playerName)
                        .background(
                            Rectangle()
                                .foregroundColor(.mmPinkButton)
                                .cornerRadius(10)
                                .frame(width: 340, height: 100, alignment: .center)
                        )
                        .focused($isFocused)
                        .frame(width: 300)
                        .font(Font.custom("RedBurger", size: 30))
                        .foregroundColor(.black)
                        .onTapGesture {
                            isFocused = true
                        }
                        .onChange(of: playerName){
                            savedPlayerName = playerName
                        }
                        .onAppear(){
                            playerName = savedPlayerName
                        }
                }
                .ignoresSafeArea(.keyboard)
                
                Image(.monkeyOnMarsPlanet)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(CGPoint(x: 180, y: 180))
                
                roundedButton(title: "Play", action: {
                    if playerName != ""{
                        withAnimation { self.currentGameState = .playing }
                    }
                    else{
                        withAnimation { isWarningPresented = true }
                    }
                })
                
                roundedButton(title: "Leaderboard", action: {
                    withAnimation { self.currentGameState = .leaderboard }
                })
                
                Spacer()
            }
            .padding(.horizontal)
            
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

