//
//  DataItem.swift
//  MarsMonkey
//
//  Created by Massimo Paloscia on 11/12/23.
//

import Foundation
import SwiftData

// Define Data Item for Swift Data
@Model
class MyDataItem: Identifiable {
    
    var id: UUID
    
    // User name from text Field
    var name: String
    
    // User highest score
    var score: String
    
    init(name: String, score: String){
        self.id = UUID()
        self.name = name
        self.score = score
    }
}
