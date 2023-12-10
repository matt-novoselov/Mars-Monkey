//
//  Constants.swift
//  MarsMonkey
//
//  Created by Mariia Chemerys on 10.12.2023.
//

import Foundation
import SwiftUI

enum GameState{
    case menu
    case playing
    case timeIsUp
    case redLineIsHit
}

struct GameConstants{
    
    // Timer Constant
    let timerDurationInSeconds: Int = 120
}
