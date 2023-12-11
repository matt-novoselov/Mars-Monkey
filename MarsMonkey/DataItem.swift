//
//  DataItem.swift
//  MarsMonkey
//
//  Created by Massimo Paloscia on 11/12/23.
//

import Foundation
import SwiftData

@Model
class MyDataItem: Identifiable {
    var id: UUID
    var name: String
    var score: String
    
    init(name: String, score: String){
        self.id = UUID()
        self.name = name
        self.score = score
    }
}
