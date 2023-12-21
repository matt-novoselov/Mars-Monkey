//
//  AudioModel.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 16/12/23.
//

import Foundation
import SpriteKit
import AVFoundation

extension GameScene{
    func initializeBackgroundMusic(filename: String) {
        if let url = Bundle.main.url(forResource: filename, withExtension: nil) {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.prepareToPlay()
            } catch {
                print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(filename)")
        }
    }

    func playBackgroundMusic() {
        backgroundMusicPlayer?.play()
    }

    func updateBackgroundMusicVolume() {
        DispatchQueue.main.async {
            if let player = self.backgroundMusicPlayer {
                let newVolume: Float = 1.0
                player.volume = newVolume
                print("Updated volume: \(player.volume)")
            } else {
                print("Background music player is nil.")
            }
        }
    }

    
    func stopBackgroundMusic() {
        self.backgroundMusicPlayer?.stop()
    }
        
    func playOneShotSound(filename: String) {
        let soundAction = SKAction.playSoundFileNamed("\(filename).mp3", waitForCompletion: false)
        player.run(soundAction)
    }

}
