//
//  Timer Model.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 11/12/23.
//

import SwiftUI
import Foundation

class TimerModel: ObservableObject {
    @Published var seconds: Int = GameConstants().timerDurationInSeconds
    
    var formattedTime: String {
            let minutes = seconds / 60
            let seconds = self.seconds % 60
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
            if self.seconds > 0 {
                self.seconds -= 1
            } else {
                self.timer?.invalidate()
            }

            // Esempio: Decrementa di 10 secondi in certe circostanze
            if self.seconds == 60 {
                self.decrementTimer(by: 10)
            }

            // Esempio: Decrementa di 10 secondi in un altro caso
            if self.seconds == 30 {
                self.decrementTimer(by: 10)
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    func decrementTimer(by amount: Int) {
        if seconds > amount {
            seconds -= amount
        } else {
            seconds = 0
            stopTimer()
        }
    }
}
