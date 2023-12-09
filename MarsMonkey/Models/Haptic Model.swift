import SwiftUI
import CoreHaptics

// This function is used to perform light haptic feedback. Used when pressing a button
func lightHaptic() {
    let lightHaptic = UIImpactFeedbackGenerator(style: .light)
    lightHaptic.impactOccurred()
}
