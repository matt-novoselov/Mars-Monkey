//
//  PlantingTreeView.swift
//  MarsMonkey
//
//  Created by Gabriele Perillo on 13/12/23.
//

import SwiftUI

struct PlantingTreeView: View {
    
    @State private var progress: CGFloat = 0.5 // Set your initial progress value here
    
    var body: some View {
        ZStack {
            Group{
                Circle()
                    .stroke(lineWidth: 15.0)
                    .foregroundColor(Color.pinkTreeCircle)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.greenTree)
                    .rotationEffect(Angle(degrees: 270.0)) // Start from the top
            }
            .frame(width: 180, height: 180)

            Image("planting spot")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 125)
        }
        .padding(20)
    }
}

#Preview {
    PlantingTreeView()
}
