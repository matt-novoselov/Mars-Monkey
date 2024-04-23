//
//  LeaderboardModel.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 15/12/23.
//

import Foundation
import SwiftData


// Function to add a new record to the score database or update previous value
func addAndCheckItem(playerName: String, score: String, items: [MyDataItem]) -> MyDataItem {
    
    // If user exists, update the score, if it is higher than previous one
    if let index = items.firstIndex(where: {item in
        item.name == playerName})
    {
        if (Int(items[index].score) ?? 0 < Int(score) ?? 0){
            items[index].score = score
            return MyDataItem(name: "nil", score: "nil")
        }
    }
    // Otherwise, add a new record to the database with the initial score
    else{
        let newItem = MyDataItem(name: playerName, score: score)
        return newItem
    }
    return MyDataItem(name: "nil", score: "nil")
}

// Function to return all user names and scores in the decreasing order for the leaderboard
func ordinatedItems(items: [MyDataItem]) -> [MyDataItem] {
    var sortedItems: [MyDataItem] {
        return items.sorted { Int($0.score) ?? 0 > Int($1.score) ?? 0 }
    }
    
    return sortedItems
}
