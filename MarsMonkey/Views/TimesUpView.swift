//
//  TimesUpView.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

struct TimesUpView: View {
    var amountOfBananasPlanted: Int
    
    var body: some View {
        VStack(spacing: 20){
            StrokeText(text: "Time’s up!", width: 1)
                .font(Font.custom("RedBurger", size: 48))
                .foregroundColor(.white)
            
            Image(.timesUpMonkey)
            
            StrokeText(text: "Congrats on planting \(amountOfBananasPlanted) banana trees", width: 1)
                .font(Font.custom("RedBurger", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            roundedButton(title: "Menu", fontSize: 24, action: {})
            
            roundedButton(title: "Leaderboard", fontSize: 24, action: {})
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mmPink)
    }
}

#Preview {
    TimesUpView(amountOfBananasPlanted: 10)
}
