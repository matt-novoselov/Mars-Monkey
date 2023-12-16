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
        if let url = Bundle.main.url(forResource: filename, withExtension: nil) {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundMusicPlayer?.play()
            } catch {
                // Handle error
            }
        }
    }
}
