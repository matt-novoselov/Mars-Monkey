//
//  LeaderboardModel.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 15/12/23.
//

import Foundation
import SwiftData


func addAndCheckItem(playerName: String, score: String, items: [MyDataItem]) -> MyDataItem {
    if let index = items.firstIndex(where: {item in
        item.name == playerName})
    {
        if (Int(items[index].score) ?? 0 < Int(score) ?? 0){
            items[index].score = score
            return MyDataItem(name: "nil", score: "nil")
        }
    }
    else{
        let newItem = MyDataItem(name: playerName, score: score)
        return newItem
    }
    return MyDataItem(name: "nil", score: "nil")
}

func ordinatedItems(items: [MyDataItem]) -> [MyDataItem] {
    var sortedItems: [MyDataItem] {
        return items.sorted { Int($0.score) ?? 0 > Int($1.score) ?? 0 }
    }
    
    return sortedItems
}
