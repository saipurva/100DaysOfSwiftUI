//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Diana Harjani on 13/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct Arrows: Shape{  //challenge 1
    var insetAmount: CGFloat
    var animatableData: CGFloat{
        get {
            insetAmount
        }
        set{
            self.insetAmount += newValue
        }
    }
    
    func path(in rect: CGRect)-> Path{
        var path = Path()
        path.move(to:CGPoint(x: rect.maxX * 1/3, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * 1/3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 2/3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 2/3, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * 1/3, y: rect.minY))

        return path
    }
}

struct colorCyclingRectangle: View{
    var amount = 0.0
    var steps = 50
    
    var body: some View{
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if  targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var insetAmount: CGFloat = 50
    @State private var thikness: CGFloat = 10
    @State private var isBig = false
    
    @State private var colorCycle = 0.0
    
    
    var body: some View {
        VStack{
            colorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height: 200)
            Text("Color Cycle")
            Slider(value: $colorCycle)
            
            Arrows(insetAmount: insetAmount)
                .stroke(Color.red, style: StrokeStyle(lineWidth: thikness, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 150)
                .onTapGesture { //Challenge 2
                    withAnimation{
                        self.isBig.toggle()
                        self.thikness = self.isBig ? 20.0 : 5.0
                    }
            }
//            Text("Thikness")
//            Slider(value: $thikness, in: 0...70)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
