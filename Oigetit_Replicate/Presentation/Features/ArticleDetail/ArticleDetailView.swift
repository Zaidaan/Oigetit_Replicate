//
//  ArticleDetailView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct ArticleDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: ArticleDetailViewModel
    @AppStorage("isDarkModeOn") var isDarkModeOn: Bool = false
    
    @State var isLiked: Bool = false
    @State var isSaved: Bool = false
    
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
                    Image(sentiment.icon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .foregroundStyle(sentiment.color)
                        .shadow(color: sentiment.color, radius: 0.5)
                    
                    Text("Sentiment")
                        .font(Font.caption)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(width: 15)
                        .foregroundStyle(Color.gray)
                }
                .onTapGesture {
                    router.present(fullScreenCover: .sentimentRateInfoModal)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(ColorSet.white)
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(ColorSet.blue),
                alignment: .top
            )
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(ColorSet.blue),
                alignment: .bottom
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
                            .foregroundColor(ColorSet.blue)
                        
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
                .background(ColorSet.white)
            }
        }
        .safeAreaPadding(.bottom, 36)
        .onAppear{
            Task {
                viewModel.content = await viewModel.fetchContent()
            }
        }
        .overlay(
            VStack {
                Spacer()
                HStack{
                    Button(
                        action: {
                            isLiked.toggle()
                        },
                        label: {
                            Image(systemName: isLiked ? IconSet.likeFill : IconSet.like)
                                .resizable()
                                .aspectRatio(1/1, contentMode: .fit)
                                .frame(width: 35)
                                .fontWeight(Font.Weight.semibold)
                                .foregroundStyle(isLiked ? ColorSet.blueLikeButton : ColorSet.blue)
                        }
                    )
                    
                    Spacer()
                    
                    Button(
                        action: {
                            router.present(sheet: .articleCommentSheet, detents: [.fraction(0.5), .large])
                        },
                        label: {
                            Image(systemName: IconSet.comment)
                                .resizable()
                                .aspectRatio(1/1, contentMode: .fit)
                                .frame(width: 32)
                                .fontWeight(Font.Weight.semibold)
                                .foregroundStyle(ColorSet.blue)
                        }
                    )
                    
                    Spacer()
                    
                    ShareLink(item: viewModel.article.title){
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 37)
                            .fontWeight(Font.Weight.semibold)
                            .foregroundStyle(ColorSet.blue)
                    }
                    
                    Spacer()
                    
                    Button(
                        action: {
                            isSaved.toggle()
                        },
                        label: {
                            Image(systemName: isSaved ? "bookmark.fill" : IconSet.save)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 35)
                                .fontWeight(Font.Weight.semibold)
                                .foregroundStyle(isSaved ? ColorSet.saveButton : ColorSet.blue)
                        }
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                .padding(.top, 12)
                .padding(.horizontal, 28)
                .background(ColorSet.white)
                .overlay(Rectangle().stroke(ColorSet.blue, lineWidth: 2))
            }
                .ignoresSafeArea(edges: .bottom)
        )
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
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: {
                        isDarkModeOn.toggle()
                    },
                    label: {
                        Image(systemName: colorScheme == .light ? "moon" : "moon.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .fontWeight(Font.Weight.light)
                            .foregroundStyle(colorScheme == .light ? Color.white : ColorSet.blueButton)
                            
                    }
                )
//                .padding()
                .overlay(
                    Circle()
                        .stroke(colorScheme == .light ? Color.clear : ColorSet.blueButton, lineWidth: 2)
                )
            }
            .sharedBackgroundVisibility(.hidden)
            ToolbarItem(placement: .principal) {
                VStack{
                    Image("OigetitLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90)
                    Text("Your Daily Fact-checked News")
                        .font(Font.caption2.bold())
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
