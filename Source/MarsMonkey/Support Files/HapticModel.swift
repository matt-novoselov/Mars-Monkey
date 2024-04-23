//
//  Constants.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//


import SwiftUI
import CoreHaptics

// This function is used to perform light haptic feedback.
func lightHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .light)
    lightHaptic.impactOccurred()
}

// This function is used to perform soft haptic feedback.
func softHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .soft)
    lightHaptic.impactOccurred()
}

// This function is used to perform heavy haptic feedback
func heavyHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .heavy)
    lightHaptic.impactOccurred()
}

// This function is used to perform a sequence of haptic feedbacks.
func sequenceHeavyHaptic() {
    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
}

