//
//  ArticleDetailView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct ArticleDetailView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: ArticleDetailViewModel
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleDetailViewModel(article: article))
    }
    
    var body: some View {
        let sentiment = identifySentiment(sentiment: viewModel.article.score.sentiment)
        VStack(spacing: 0) {
            HStack(alignment: .center){
                ReliabilityScore(score: viewModel.article.score.reliability)
                Text("Reliability\nScore")
                    .font(Font.footnote)
                
                Spacer()
                
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
            }
            
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .overlay(
                Rectangle()
                    .stroke(Color.blue, lineWidth: 1.5)
            )
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    if viewModel.isMediaVisible {
                        
                        if let url = URL(string: viewModel.article.thumbnail) {
                            
                            AsyncImage(url: url){ phase in
                                switch phase {
                                case .empty:
                                    Color.clear.frame(width: 0, height: 0)
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                case .failure(_):
                                    Color.clear.frame(width: 0, height: 0)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    if !viewModel.hasMediaLoaded {
                                        withAnimation {
                                            viewModel.isMediaVisible = true
                                        }
                                    } else {
                                        withAnimation {
                                            viewModel.isMediaVisible = false
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                    } else {
                        EmptyView()
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.article.categories.first?.uppercased() ?? "NEWS")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text(viewModel.article.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack {
                            Text("By \(viewModel.article.publisher)")
                                .fontWeight(.medium)
                            Spacer()
                            Text(viewModel.article.publishedAt.formatted(date: .abbreviated, time: .omitted))
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        
                        Divider()
                        
                        Text(viewModel.content)
                            .font(.body)
                            .lineSpacing(6)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear{
            Task {
                viewModel.content = await viewModel.fetchContent()
            }
        }
        .toolbarBackground(ColorSet.blue, for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button{
                    router.pop()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.white)
                }
            }
            .sharedBackgroundVisibility(.hidden)
            ToolbarItem(placement: .principal) {
                VStack{
                    Image("OigetitLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                    Text("Oigetit")
//                        .font(Font.title)
//                        .fontWeight(.semibold)
                    Text("Your Daily Fact-checked News")
                        .font(Font.caption)
                }
                .foregroundStyle(Color.white)
                
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}


#Preview {
    let dummyArticle = Article(
        id: "F6A7B8C9-D0E1-2345-6789-ABCDEF012345",
        title: "Space Agency Releases Stunning New Images of Distant Galaxy",
        thumbnail: "https://images.unsplash.com/photo-1462331940025-496dfbfc7564?q=80&w=400&auto=format&fit=crop",
        categories: ["Breaking"],
        publishedAt: Date.now,
        publisher: "AstroWeekly",
        score: NewsScore(reliability: 80, sentiment: "positive")
    )
    AppRouterView(previewPage: .articleDetail(article: dummyArticle))
}
