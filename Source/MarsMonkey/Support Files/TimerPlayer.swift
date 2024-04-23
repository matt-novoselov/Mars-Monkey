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
    
    private var timer: Timer?
    
    // A total amount of seconds left until the game over
    @Published var secondsLeft: Int = 0
    
    // Return time in the formatted value
    var formattedTime: String {
        let minutes = secondsLeft / 60
        let seconds = self.secondsLeft % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
    // This function starts, decrement and increment the timer
    func startTimer() {
        // Get initial timer duration from game constants
        secondsLeft = GameConstants().timerDurationInSeconds
        
        // Update timer each second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondsLeft > 0 {
                self.secondsLeft -= 1
            } else {
                self.stopTimer()
            }
        }
    }
    
    // Function to stop timer completely
    func stopTimer() {
        timer?.invalidate()
        secondsLeft = 0
    }

    // Increase or decrease an amount of seconds left until game over
    // For example, when player collides with asteroid, timer is decreased by -10
    func modifyTimer(by amount: Int) {
        if secondsLeft + amount > 0{
            secondsLeft += amount
        }
        else{
            stopTimer()
        }
    }
}
