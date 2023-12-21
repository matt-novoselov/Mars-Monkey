//
//  GameView.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject var gameLogic: GameLogic = GameLogic.shared
    @Binding var currentGameState: GameState
    @State private var showingPauseMenu = false
    @State private var showingWarningPopup = false
    
    @State private var soundEffectsVolume: Double = 0
    @State private var musicVolume: Double = 0

    var gameScene: GameScene!
    
    var scene: GameScene {
            GameScene(timerModel: TimerModel.shared)
        }
    

    var body: some View {
        ZStack(alignment: .top){

            // SpriteKit staff
            
            SpriteView(
                scene: scene,
                isPaused: showingPauseMenu
                //,debugOptions: [.showsPhysics]
            )
            .ignoresSafeArea()
  
            // UI overlay elements
            HStack(alignment: .center){
                Button("[||]"){
                    showingPauseMenu.toggle()
                }
                
                Spacer()
                
                GameScore(currentScore: gameLogic.currentScore)
            }
            .padding(.horizontal)
            
            HStack(alignment: .center){
                TimerView(currentGameState: $currentGameState)
            }
            
            if showingPauseMenu{
                ZStack{
                    Color(.black)
                        .padding(.all, -100)
                        .ignoresSafeArea()
                        .opacity(0.3)
                    
                    VStack{
                        StrokeText(text: "Settings", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 36))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                        StrokeText(text: "Sound effects volume", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        
                        Slider(value: $soundEffectsVolume, in: -0...0.5)
                            .onChange(of: soundEffectsVolume){
                                GameLogic.shared.savedSoundEffectsVolume = soundEffectsVolume
                            }
                            .onAppear(){
                                soundEffectsVolume = GameLogic.shared.savedSoundEffectsVolume
                            }
                        
                        Spacer()
                        
                        StrokeText(text: "Music volume", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        
                        Slider(value: $musicVolume, in: -0...0.5)
                            .onChange(of: musicVolume){
                                GameLogic.shared.savedMusicVolume = musicVolume
                            }
                            .onAppear(){
                                musicVolume = GameLogic.shared.savedMusicVolume
                            }
                        
                        Spacer()
                                                
                        roundedButton(title: "Exit game", fontSize: 24, action: {
                            showingWarningPopup = true
                        })
                        
                        roundedButton(title: "Continue", fontSize: 24, action: {
                            showingPauseMenu = false
                        })
                    }
                    .padding()
                    .background(.mmPink)
                    .cornerRadius(10)
                }
                .padding()
            }
            
            
            if showingWarningPopup{
                ZStack{
                    Color(.black)
                        .padding(.all, -100)
                        .ignoresSafeArea()
                        .opacity(0.3)
                    
                    VStack{
                        Spacer()
                        
                        StrokeText(text: "Are you sure you want to exit?", strokeWidth: 1)
                            .font(Font.custom("RedBurger", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        roundedButton(title: "Exit", fontSize: 24, action: {
                            currentGameState = .menu
                        })
                        
                        roundedButton(title: "Stay", fontSize: 24, action: {
                            showingWarningPopup = false
                        })
                    }
                    .padding()
                    .frame(maxHeight: 300)
                    .background(.mmPink)
                    .cornerRadius(10)
                }
                .padding()
            }
            
            
            
        }
    }
}

#Preview {
    GameView(currentGameState: .constant(GameState.playing))
}
