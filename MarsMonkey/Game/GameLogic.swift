//
//  GameLogic.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import Foundation
import AVFoundation

class GameLogic: ObservableObject{
    let gameConstants: GameConstants = GameConstants()
    var backgroundMusicPlayer: AVAudioPlayer?
    
    // Variable Used To Transfer the Values of Variables from this File to Other Files
    static let shared: GameLogic = GameLogic()
    
    // Sets Values of Variables at the Beginning of the Game
    func setUpGame(){
        self.currentScore = 0
        self.isTimeUp = false
    }
    
    // Variable Used to Store the Current Score of the Player
    @Published var currentScore: Int = 0
    
    // Increases the Score by One
    func scoreIncreaseByOne(points: Int) {
        self.currentScore += 1
    }
    
    // Game Finishing Conditions:
    
    @Published var isTimeUp: Bool = false
    func finishTheGameWhenTimeIsUp() {
        if self.isTimeUp == false {
            self.isTimeUp = true
            print("The game was finished, because the timer expired")
        }
    }

    // Background music
    
        init() {}

        func playBackgroundMusic() {
            let musicPath = Bundle.main.url(forResource: "Background_music", withExtension: "mp3")

            do {
                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicPath!)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.prepareToPlay()
                backgroundMusicPlayer?.play()
            } catch {
                print("Errore durante la riproduzione della musica di sottofondo.")
            }
        }
}
