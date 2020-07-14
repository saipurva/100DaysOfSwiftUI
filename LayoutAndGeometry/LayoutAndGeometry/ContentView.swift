//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Diana Harjani on 04/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple,.yellow]
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical){
                ForEach(0..<30) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(self.colors[index % 7])
                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 3), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
