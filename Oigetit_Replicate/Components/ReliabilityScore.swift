//
//  ReliabilityScoreView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct ReliabilityScore: View {
    var score: Int
    var width: CGFloat = 1.5
    
    private var scoreColor: Color {
        if score > 64 {return .green}
        if score > 34 {return .orange}
        else {return .red}
    }
    
    @State var animatedScore: Double = 0
    
    var body: some View {
        HStack {
            ZStack{
                HStack {
                    Image(systemName: "checkmark.shield")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                        .foregroundStyle(scoreColor)
                        .padding(.trailing,40)
                }
                
                HStack{
                    PercentageDisplay(score: animatedScore, width: width, scoreColor: scoreColor)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 28, weight: .bold))
                        .padding(.leading, 25)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(0.2)) {
                self.animatedScore = Double(score)
            }
        }
    }
}

internal struct PercentageDisplay: View, Animatable {
    
    var score: Double
    let width: CGFloat
    let scoreColor: Color
    
    var animatableData: Double {
        get {score}
        set {score = newValue}
    }
    
    var body: some View {
        
        let displayScore = Int(score.rounded())
        
        ZStack{
            ZStack{
                Text("\(displayScore)%")
                    .offset(x: width, y: width)
                Text("\(displayScore)%")
                    .offset(x: -width, y: width)
                Text("\(displayScore)%")
                    .offset(x: -width, y: -width)
                Text("\(displayScore)%")
                    .offset(x: width, y: -width)
            }
            .foregroundStyle(Color(scoreColor))
            Text("\(displayScore)%")
        }
    }
}


#Preview {
    ReliabilityScore(score: 80)
}


