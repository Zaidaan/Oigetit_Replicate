//
//  NewsCard.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct NewsCard: View {
    let article: Article
    
    @Binding var isLoading: Bool
    
    @State private var hasMediaLoaded: Bool = false
    @State private var isMediaVisible: Bool = true
    
    var body: some View {
        
        if isLoading {
            EmptyView()
        }
        
        else {
            let sentiment = identifySentiment(sentiment: article.score.sentiment)
            VStack(alignment: .leading, spacing: 12){
                HStack{
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            ReliabilityScore(score: article.score.reliability)
                            Text("Reliability\nScore")
                                .font(Font.footnote)
                        }
                        Text(article.title)
                            .font(Font.headline)
                            .lineLimit(3)
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
                    
                    if isMediaVisible {
                        
                        if let url = URL(string: article.thumbnail) {
                            
                            AsyncImage(url: url){ phase in
                                switch phase {
                                case .empty:
                                    Color.clear
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(5/4, contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .redacted(reason: .placeholder)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(5/4, contentMode: .fit)
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
                    HStack{
                        Image(systemName: sentiment.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundStyle(sentiment.color)
                        Text("Sentiment")
                            .font(Font.caption)
                            .fontWeight(.semibold)
                        Button{
                            
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(1/1, contentMode: .fit)
                                .frame(width: 15)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 16) {
                        Image(systemName: "hand.thumbsup")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 20)
                        
                        Image(systemName: "bubble")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .frame(width: 20)
                        
                        Image(systemName: "arrowshape.turn.up.forward")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .frame(width: 20)
                        
                        Image(systemName: "ellipsis")
                            .resizable()
                            .rotationEffect(Angle(degrees: 90))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
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
}


