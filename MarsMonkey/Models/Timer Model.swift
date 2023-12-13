//
//  Timer Model.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 11/12/23.
//

import SwiftUI
import Foundation

class TimerModel: ObservableObject {
    static let shared = TimerModel()
    @Published var secondsLeft: Int = GameConstants().timerDurationInSeconds
    
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
            } else {
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        secondsLeft = 0
    }

    func modifyTimer(by amount: Int) {
        if secondsLeft + amount > 0{
            secondsLeft += amount
        }
        else{
            stopTimer()
        }
    }
}
