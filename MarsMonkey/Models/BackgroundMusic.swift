//
//  BackgroundMusic.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 14/12/23.
//

import SwiftUI
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

//override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    playBackgroundMusic()
//}

func playBackgroundMusic() {
    let musicPath = Bundle.main.url(forResource: "nomemusica", withExtension: "mp3")

    do {
        try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicPath!)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch {
        print("Errore durante la riproduzione della musica di sottofondo.")
    }
}
