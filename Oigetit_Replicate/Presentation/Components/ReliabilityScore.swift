//
//  ReliabilityScoreView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct ReliabilityScore: View {
    var score: Int
    var width: CGFloat = 1
    
    private var scoreAttributes: (Color,String) {
        if score > 64 {return (ColorSet.green, IconSet.shieldWithCheckmark)}
        if score > 34 {return (ColorSet.orange, IconSet.shieldOutline)}
        else {return (ColorSet.red, IconSet.shieldWithXmark)}
    }
    
    @State var animatedScore: Double = 0
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading){
                HStack {
                    Image(systemName: scoreAttributes.1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(scoreAttributes.0)
                        .fontWeight(Font.Weight.light)
                        .padding(.trailing,40)
                }
                
                HStack{
                    PercentageDisplay(score: animatedScore, width: width, scoreColor: scoreAttributes.0)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 24, weight: .medium))
                }
                .padding(.leading, 23)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(0.2)) {
                self.animatedScore = Double(score)
            }
        }
    }
}

private struct PercentageDisplay: View, Animatable {
    
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


