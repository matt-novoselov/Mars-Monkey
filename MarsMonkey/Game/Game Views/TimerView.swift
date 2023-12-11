//
//  TimerView.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 11/12/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerModel = TimerModel()
    
    var body: some View {
        VStack {
            StrokeText(text: "\(timerModel.formattedTime)", strokeWidth: 1)
                .font(Font.custom("RedBurger", size: 48))
                .foregroundColor(.mmPink)
        }
    }
}

#Preview {    
    TimerView()
}



