//
//  NewsCard.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct NewsCard: View {
    let article: Article
    
    @State private var hasMediaLoaded: Bool = false
    @State private var isMediaVisible: Bool = true
    
    var body: some View {
        let sentiment = identifySentiment(sentiment: article.score.sentiment)
        VStack(alignment: .leading, spacing: 8){
            HStack{
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        ReliabilityScore(score: article.score.reliability)
                        Text("Reliability\nScore")
                            .font(Font.caption)
                            .fontWeight(Font.Weight.medium)
                            .foregroundStyle(Color.gray)
                    }
                    Text(article.title)
                        .font(Font.headline)
                        .lineLimit(3)
                    
                    Spacer()
                    
                    HStack{
                        Text(article.publisher)
                            .lineLimit(1)
                        Circle()
                            .frame(width: 4, height: 4)
                        Text(article.publishedAt.timeAgoDisplay())
                    }
                    .font(Font.caption2)
                    .foregroundStyle(.gray)
                }
                
                Spacer()
                
                if isMediaVisible {
                    
                    if let url = URL(string: article.thumbnail) {
                        
                        AsyncImage(url: url){ phase in
                            switch phase {
                            case .empty:
                                Color.clear
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(7/6, contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .redacted(reason: .placeholder)
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(maxWidth: 150)
                                    .aspectRatio(4/3, contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onAppear {
                                        hasMediaLoaded = true
                                    }
                            case .failure(_):
                                Color.clear.frame(width: 0, height: 0)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                if !hasMediaLoaded {
                                    withAnimation {
                                        isMediaVisible = false
                                    }
                                } else {
                                    withAnimation {
                                        isMediaVisible = true
                                    }
                                }
                            }
                        }
                        
                    }
                } else {
                    EmptyView()
                }
                
            }
            
            Divider()
            
            HStack{
                HStack(spacing: 6){
                    Image(sentiment.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundStyle(sentiment.color)
                    Text("Sentiment")
                        .font(Font.caption)
                        .fontWeight(.medium)
                    Button{
                        
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .frame(width: 12)
                            .foregroundStyle(Color.gray)
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: IconSet.like)
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(width: 20)
                        .fontWeight(Font.Weight.light)
                    
                    Image(systemName: IconSet.comment)
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(width: 20)
                        .fontWeight(Font.Weight.light)
                    
                    Image(systemName: IconSet.share)
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(width: 20)
                        .fontWeight(Font.Weight.light)
                    
                    Image(systemName: IconSet.more)
                        .resizable()
                        .rotationEffect(Angle(degrees: 90))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .fontWeight(Font.Weight.black)
                }
                
                .foregroundStyle(Color.gray)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}


