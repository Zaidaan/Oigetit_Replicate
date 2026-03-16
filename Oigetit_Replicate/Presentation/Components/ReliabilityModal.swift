//
//  ReliabilityRateModal.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 16/03/26.
//

import SwiftUI

struct ReliabilityModal: View {
    
    @EnvironmentObject var router: AppRouter
    
    let score: Int
    
    private var scoreAttributes: (Color,String,String) {
        if score > 64 {return (ColorSet.green, "Real News", IconSet.shieldWithCheckmark)}
        if score > 34 {return (ColorSet.orange, "Mostly Real", IconSet.shieldOutline)}
        else {return (ColorSet.red, "Fake News", IconSet.shieldWithXmark)}
    }
    
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
            
            VStack{
                VStack(alignment: .center, spacing: 16){
                    HStack{
                        Text(scoreAttributes.1)
                            .font(.title3)
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                            .foregroundStyle(scoreAttributes.0)
                    }
                    
                    ZStack{
                        Image(systemName: scoreAttributes.2)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundStyle(scoreAttributes.0.opacity(0.3))
                            .offset(x: 0, y: 2)
                        Text("This article was fact-checked and \(score)% of the content is factual")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                    }
                    .padding(.horizontal,20)
                    .padding(.bottom, 12)
                    
                    VStack{
                        Text("For more information:")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.gray)
                        Button{
                            
                        } label: {
                            Text("Visit Frequently Asked Questions")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(ColorSet.blueButton)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                    }
                }
                .padding(.vertical,16)
                .padding(.horizontal,16)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    VStack{
                        Button{
                            withAnimation(.easeInOut(duration: 0.5)){
                                contentOpacity = 0.0
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                router.dismissFullScreenCover()
                            }
                            
                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName: "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:10, height:15)
                                    .foregroundStyle(Color.gray)
                                    .fontWeight(Font.Weight.medium)
                            }
                            .padding(.top,8)
                            .padding(.horizontal, 20)
                        }
                        Spacer()
                    }
                )
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


#Preview {
    var score: Int = 80
    
    ReliabilityModal(score: score)
}
