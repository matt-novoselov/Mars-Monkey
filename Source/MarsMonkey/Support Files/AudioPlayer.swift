//
//  AudioModel.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 16/12/23.
//

import Foundation
import SpriteKit
import AVFoundation

// Extensions to play music or sound effects
extension GameScene{
    
    // Function to play background music in the game scene on the loop
    func playBackgroundMusic(filename: String) {
        // Adjust background volume
        let backgroundVolume: Float = 0.05
        
        DispatchQueue.global().async {
            if let url = Bundle.main.url(forResource: filename, withExtension: nil) {
                do {
                    self.backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                    self.backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                    self.backgroundMusicPlayer?.volume = backgroundVolume
                    self.backgroundMusicPlayer?.prepareToPlay()
                    self.backgroundMusicPlayer?.play()
                } catch {
                    print("Unable to play background music")
                }
            }
        }
    }
    
    // Function to stop background music in the game scene
    func stopBackgroundMusic() {
        self.backgroundMusicPlayer?.stop()
        self.backgroundMusicPlayer = nil
    }
    
    // Function to play sound effect one time
    func playOneShotSound(filename: String) {
        let soundAction = SKAction.playSoundFileNamed("\(filename).mp3", waitForCompletion: false)
        player.run(soundAction)
    }
}
