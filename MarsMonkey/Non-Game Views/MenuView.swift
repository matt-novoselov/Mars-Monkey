
//  MenuView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 09.12.2023.


import SwiftUI

struct MenuView: View {
    
    @Binding var currentGameState: GameState
    
    @State var playerName: String = ""
    
    var body: some View {
        ZStack {
            Color(.mmUIBackground)
                .ignoresSafeArea()
            
            VStack{
                StrokeText(text: "Mars Monkey", strokeWidth: 1)
                    .font(Font.custom("RedBurger", size: 55))
                    .foregroundColor(.mmPink)

                HStack {
                    TextField("Enter your name", text: $playerName)
                        .background(
                            Rectangle()
                                .foregroundColor(Color("MM Pink Button"))
                                .cornerRadius(10)
                                .frame(width: 340, height: 100, alignment: .center)
                        )
                        .frame(width: 300)
                        .font(Font.custom("RedBurger", size: 30))
                        .foregroundColor(.black)
                }
                .ignoresSafeArea(.keyboard)
                
                Image(.monkeyOnMarsPlanet)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(CGPoint(x: 180, y: 180))
                
                roundedButton(title: "Play", action: {
                    withAnimation { self.currentGameState = .playing }
                })
                
                roundedButton(title: "Leaderboard", action: {
                    withAnimation { self.currentGameState = .leaderboard }
                })
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
}


#Preview {
    MenuView(currentGameState: .constant(GameState.menu))
}

