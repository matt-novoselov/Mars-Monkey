//
//  TimerView.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 11/12/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerModel = TimerModel.shared
    @Binding var currentGameState: GameState
    var gameLogic: GameLogic = GameLogic.shared
    
    var body: some View {
        VStack {
            StrokeText(text: "\(timerModel.formattedTime)", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 48))
                .foregroundColor(timerModel.secondsLeft > 20 ? .white : .red)
        }
        .onChange(of: timerModel.secondsLeft){
            if timerModel.secondsLeft == 0{
                let newGameState: GameState = gameLogic.finishTheGameWhenTimeIsUp()
                withAnimation { currentGameState = newGameState }
            }
        }
        .onAppear(){
            timerModel.startTimer()
        }
    }
}

#Preview {
    TimerView(currentGameState: .constant(.playing))
}
