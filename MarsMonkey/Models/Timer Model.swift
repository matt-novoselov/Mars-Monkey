//
//  Timer Model.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 11/12/23.
//

import SwiftUI
import Foundation

class TimerModel: ObservableObject {
    @Published var secondsLeft: Int = GameLogic.shared.secondsLeft
    
    var formattedTime: String {
            let minutes = secondsLeft / 60
            let seconds = self.secondsLeft % 60
            return String(format: "%01d:%02d", minutes, seconds)
        }
    
    private var timer: Timer?

    // To inizialize the timer
    init() {
        startTimer()
    }
    
    // This function starts, decrement and increment the timer in some cases
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondsLeft > 0 {
                self.secondsLeft -= 1
                GameLogic.shared.secondsLeft = self.secondsLeft
            } else {
                self.timer?.invalidate()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    func decrementTimer(by amount: Int) {
        if secondsLeft > amount {
            secondsLeft -= amount
        } else {
            secondsLeft = 0
            stopTimer()
        }
        GameLogic.shared.secondsLeft = self.secondsLeft
    }
}
