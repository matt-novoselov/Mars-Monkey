import SwiftUI
import CoreHaptics

// This function is used to perform light haptic feedback. Used when pressing a button
func lightHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .light)
    lightHaptic.impactOccurred()
}

// This function is used to perform soft haptic feedback. Used when pressing a button
func softHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .soft)
    lightHaptic.impactOccurred()
}

// This function is used to perform heavy haptic feedback. Used when pressing a button
func heavyHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .heavy)
    lightHaptic.impactOccurred()
}
