//
//  TopPlayerCard.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 22/04/24.
//

import SwiftUI

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

#Preview {
    TopPlayerCard(TopPlayerName: "Top Player", TopPlayerScore: "100")
}
