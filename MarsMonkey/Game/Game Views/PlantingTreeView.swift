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
        VStack {
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.3)
                    .foregroundColor(Color.pinkTreeCircle)
                    .frame(width: 160, height: 160)
                
                Image("planting spot")
                    .resizable()
                    //.scaledToFit()
                    //.clipShape(Circle())
                    .frame(width: 125, height: 125)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.greenTree)
                    .rotationEffect(Angle(degrees: 270.0)) // Start from the top
                    .frame(width: 160, height: 160)
                
            }
            .padding(20)
            
            Spacer()
            //
            //            Button("Increase Progress") {
            //                withAnimation {
            //                    progress += 0.1 // Increment the progress value
            //                    if progress > 1.0 {
            //                        progress = 1.0 // Ensure progress doesn't exceed 1.0
            //                    }
            //                }
            //            }
            //          .padding()
        }
    }
}

#Preview {
    PlantingTreeView()
}
