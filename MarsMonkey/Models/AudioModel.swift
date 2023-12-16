//
//  AudioModel.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 16/12/23.
//

import Foundation
import AVFoundation

extension GameScene{
    func playBackgroundMusic(filename: String) {
        DispatchQueue.global().async {
            if let url = Bundle.main.url(forResource: filename, withExtension: nil) {
                do {
                    self.backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                    self.backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                    self.backgroundMusicPlayer?.volume = 0.1
                    self.backgroundMusicPlayer?.prepareToPlay()
                    self.backgroundMusicPlayer?.play()
                } catch {
                    print("Unable to play background music")
                }
            }
        }
    }
    
    func playOneShotSound(filename: String) {
        DispatchQueue.global().async {
            if let url = Bundle.main.url(forResource: filename, withExtension: "mp3") {
                do {
                    self.oneShotAudioPlayer = try AVAudioPlayer(contentsOf: url)
                    self.oneShotAudioPlayer?.numberOfLoops = 0 // Play once
                    self.oneShotAudioPlayer?.volume = 2
                    self.oneShotAudioPlayer?.prepareToPlay()
                    self.oneShotAudioPlayer?.play()
                } catch {
                    print("Unable to play one shot audio")
                }
            }
        }
    }
}
