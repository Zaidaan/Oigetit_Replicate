//
//  SentimentInfoModal.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 16/03/26.
//

import SwiftUI

struct SentimentRateInfoModal: View {
    @EnvironmentObject var router: AppRouter
    @State var contentOpacity = 0.0
    
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea(edges: .all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.black.opacity(0.3))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)){
                        contentOpacity = 0.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        router.dismissFullScreenCover()
                    }
                }
            
            VStack {
                VStack(alignment: .center, spacing: 20) {
                    HStack(alignment:.top){
                        Text("How we rate Sentiment")
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.vertical,12)
                        Spacer()
                        Button{
                            withAnimation(.easeInOut(duration: 0.5)){
                                contentOpacity = 0.0
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                router.dismissFullScreenCover()
                            }
                            
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:10, height:15)
                                .foregroundStyle(Color.gray)
                                .fontWeight(Font.Weight.medium)
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 24){
                        
                        RateDescription(rate: .positive)
                        RateDescription(rate: .neutral)
                        RateDescription(rate: .negative)
                    }
                    
                    
                }
                .padding(.top,16)
                .padding(.bottom, 32)
                .padding(.horizontal,20)
                .background(ColorSet.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 44)
        }
        .opacity(contentOpacity)
        
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                contentOpacity = 1.0
            }
        }
    }
}

private struct RateDescription: View {
    enum Rate {
        case positive, neutral, negative
    }
    
    let rate: Rate
    
    private var highlightedText: Text {
        switch rate {
        case .positive:
            return Text("positive")
                .fontWeight(.bold)
                .foregroundStyle(ColorSet.green)
        case .neutral:
            return Text("neutral")
                .fontWeight(.bold)
                .foregroundStyle(ColorSet.orange)
        case .negative:
            return Text("negative")
                .fontWeight(.bold)
                .foregroundStyle(ColorSet.red)
        }
    }
    
    private var rateAttributes: (String, Color, String) {
        switch rate {
        case .positive:
            return ("POSITIVE SENTIMENT", ColorSet.green, IconSet.faceSmiling)
        case .neutral:
            return ("NEUTRAL SENTIMENT", ColorSet.orange, IconSet.faceNeutral)
        case .negative:
            return ("NEGATIVE SENTIMENT", ColorSet.red, IconSet.faceNeutral)
        }
    }
    
    var body: some View {
        HStack(alignment: .top){
            
            Image(rateAttributes.2)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 45)
                .foregroundStyle(rateAttributes.1)
                .shadow(color: rateAttributes.1, radius: 1)
                                
            VStack(alignment: .leading, spacing: 4){
                Text(rateAttributes.0)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(rateAttributes.1)
                Text("The author of the article had a \(highlightedText) attitude towards the topic.")
                    .font(.system(size: 13, weight: .semibold))
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SentimentRateInfoModal()
}
