//
//  TestDataView.swift
//  MarsMonkey
//
//  Created by Massimo Paloscia on 11/12/23.
//

import SwiftUI
import SwiftData

struct TestDataView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var items: [MyDataItem]
    
    @State var playerName: String = ""
    @State var score: String = ""
    var body: some View {
        VStack{
            
            TextField("Enter your name", text: $playerName)
                .background(
                    Rectangle()
                        .foregroundColor(.green)
                )
            
            TextField("Enter your score", text: $score)
                .background(
                    Rectangle()
                        .foregroundColor(.green)
                )
            
            Button("Save") {
                //                print(playerName)
                //                print(score)
                addAndCheckItem()
            }
            
            List{
                ForEach (ordinatedItems()){item in
                    
                    HStack{
                        Text(item.name)
                        Text(item.score)
                    }
                }
            }
            
            
            
        }
    }
    
    func addAndCheckItem(){
//        let item = MyDataItem(name: playerName, score: score)
        if let index = items.firstIndex(where: {item in
            item.name == playerName})
        {
            if (Int(items[index].score) ?? 0 < Int(self.score) ?? 0){
                items[index].score = score
                try? context.save()
            }
        }else{
            let newItem = MyDataItem(name: playerName, score: score)
            context.insert(newItem)
        }
        
    }
    
    func ordinatedItems() -> [MyDataItem] {
//        let sortedItems = items.sort { (item1, item2) -> Bool in
//            return item1.score < item2.score
//        }
        
        var sortedItems: [MyDataItem] {
            return items.sorted { $0.score > $1.score }
        }

        
        return sortedItems
    }
    
}

#Preview {
    TestDataView()
        .modelContainer(for: MyDataItem.self)
}
