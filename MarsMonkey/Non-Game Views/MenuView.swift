
//  MenuView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 09.12.2023.


import SwiftUI

struct MenuView: View {
    
    @State var playerName: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color("MM UI Background"))
                
            
            VStack{
                StrokeText(text: "Mars Monkey", width: 1)
                    .font(Font.custom("RedBurger", size: 55))
                    .foregroundColor(Color("MM Pink"))
                
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
                    
                
                Image("Monkey on Mars planet")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(CGPoint(x: 180, y: 180))
                
                roundedButton(title: "Play", action: {})
                    .frame(width: 350)
                roundedButton(title: "Leaderboard", action: {})
                    .frame(width: 350)

                Spacer()
            }
        }
    }
    
}

 
#Preview {
    MenuView()
}

