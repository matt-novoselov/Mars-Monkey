//
//  UIElements.swift
//  MarsMonkey
//
//  Created by Matt Novoselov on 08/12/23.
//

import SwiftUI

// This structure is used to create a round button with a custom action
struct roundedButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            let buttonHeight: Double = 90
            
            ZStack{
                RoundedRectangle(cornerRadius: 90)
                    .frame(height: buttonHeight)
                    .foregroundColor(.mmPinkButton)
                
                StrokeText(text: title, width: 1)
                    .font(Font.custom("RedBurger", size: 40))
                    .foregroundColor(.mmPinkTitle)
            }
        }
    }
}

// This structure is used to create a text with stroke
struct StrokeText: View {
    let text: String
    let width: CGFloat

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(.black)
            Text(text)
        }
    }
}

#Preview{
    VStack{
        roundedButton(title: "Play", action: {})
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.mmUIBackground)
    
}
