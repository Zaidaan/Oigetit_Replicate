//
//  RateInfoModal.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 15/03/26.
//

import SwiftUI

struct ReliabilityRateInfoModal: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isDontShowChecked: Bool = !UserDefaults.standard.bool(forKey: UserDefaultsKey.isShowHomeModal)
    @State var contentOpacity = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea(edges: .all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.black.opacity(0.3))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)){
                        contentOpacity = 0.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        dismiss()
                    }
                }
                
            
            VStack {
                VStack(alignment: .center, spacing: 28) {
                    VStack{
                        HStack {
                            Spacer()
                            Button{
                                withAnimation(.easeInOut(duration: 0.5)){
                                    contentOpacity = 0.0
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    dismiss()
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
                        HStack{
                            Text("How We Rate News")
                                .font(.title2.bold())
                            Spacer()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        RateDescription(rate: .real)
                        RateDescription(rate: .mostly)
                        RateDescription(rate: .fake)
                    }
                    
                    VStack(spacing: 20){
                        Divider()
                        
                        VStack{
                            Text("For more information:")
                                .font(.subheadline.bold())
                            Button{
                                
                            } label: {
                                Text("Visit Frequently Asked Questions")
                                    .font(.subheadline.bold())
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 28)
                                    .padding(.vertical, 16)
                                    .background(ColorSet.blueButton)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        
                        HStack{
                            Button {
                                isDontShowChecked.toggle()
                                UserDefaults.standard.set(!isDontShowChecked, forKey: UserDefaultsKey.isShowHomeModal)
                            } label: {
                                Image(systemName: isDontShowChecked ? IconSet.checkboxFill: IconSet.square)
                                    .font(.title.weight(.light))
                                    .foregroundStyle(isDontShowChecked ? ColorSet.blue : Color.gray)
                            }
                            Text("Don't show this screen again")
                                .font(.subheadline.weight(.light))
                        }
                    }
                }
                .padding(.vertical,12)
                .padding(.horizontal,20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 20)
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
        case real, mostly, fake
    }
    
    let rate: Rate
    
    private var rateAttributes: (String, String, Color, String) {
        switch rate {
        case .real:
            return ("Real News", "Article has been fact-checked against multiple sources and determinded to be highly trusted", ColorSet.green, IconSet.shieldWithCheckmarkFill)
        case .mostly:
            return ("Mostly Real", "Article is mostly factual but may contain portions that are deemed innacurate.", ColorSet.orange, IconSet.shieldFill)
        case .fake:
            return ("Fake News", "Article contains large portions of innacurate information. Please seek additional sources.", ColorSet.red, IconSet.shieldWithXmarkFill)
        }
    }
    
    var body: some View {
        HStack(alignment: .top){
            
            ZStack{
                Image(systemName: IconSet.shieldOutline)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
                    .foregroundStyle(Color.white)
                Image(systemName: rateAttributes.3)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundStyle(rateAttributes.2)
            }
            .padding(20)
            .background(rateAttributes.2.opacity(0.2))
            .clipShape(Circle())
                                
            VStack(alignment: .leading, spacing: 12){
                Text(rateAttributes.0)
                    .font(.headline)
                    .foregroundStyle(rateAttributes.2)
                Text(rateAttributes.1)
                    .font(.subheadline)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}


