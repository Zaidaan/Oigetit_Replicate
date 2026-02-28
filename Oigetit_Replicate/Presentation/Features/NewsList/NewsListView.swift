//
//  NewsListView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject var viewModel: NewsListViewModel
    
    init(category: String) {
        _viewModel = StateObject(wrappedValue: NewsListViewModel(category: category))
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(dummyCategories) { category in
                        CategoryChip(newsCategory: category, selectedCategoryId: $viewModel.selectedCategoryId) { selectedCategoryId in
                            viewModel.updateArticles(category: selectedCategoryId)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            
            TabView(selection: $viewModel.selectedCategoryId) {
                ScrollView(.vertical){
                    LazyVStack(spacing: 12){
                        ForEach(viewModel.articles.enumerated(), id: \.offset) { index, article in
                            NewsCard(article: article)
                                .onTapGesture {
                                    router.push(.articleDetail(article: article))
                                }
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea(edges: .bottom)
        .padding(.top, 12)
        .background(Color.gray.opacity(0.2))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal) {
                VStack{
                    Text("Oigetit")
                     .font(Font.title)
                     .fontWeight(.semibold)
                    Text("Fake News Filter")
                        .font(Font.caption)
                }
                .foregroundStyle(Color.white)
                
            }
            .sharedBackgroundVisibility(.hidden)
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    
                } label: {
                    HStack(spacing: 4){
                        Text("USA")
                            .font(Font.subheadline)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.down")
                            .font(Font.caption2)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.white)
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}


#Preview {
    AppRouterView(previewPage: .newsList(category: "breaking"))
    
}
