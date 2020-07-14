//
//  CardView.swift
//  Flashzilla2
//
//  Created by Diana Harjani on 03/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct CardView: View {
   @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    let card: Card
//    var removal: (() -> Void)? = nil
    var reanswer: Bool
    var removal: ((_ correct: Bool) -> Void)? = nil
    
    
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
  
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor ? nil :
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(self.setColor(for: offset.width))
//                            .fill(offset.width > 0 ? Color.green : Color.red)
            )
                .shadow(radius: 10)
            
            VStack{
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer  : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer{
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                    //remove the
                    if self.offset.width > 0 {
                        self.feedback.notificationOccurred(.success)
                    } else {
                        self.feedback.notificationOccurred(.error)
                    }
                    self.removal?(self.offset.width > 0)
                } else {
                    self.offset = .zero
                }
            }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
    
    func setColor(for offset: CGFloat) -> Color {
        switch offset {
            case let a where a > 0:
                return .blue
            case let b where b < 0:
                return  .orange
            default:
                return .white
        }
    }
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, reanswer: true)
    }
}
