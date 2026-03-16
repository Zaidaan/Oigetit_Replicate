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
                            viewModel.isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                viewModel.updateArticles(category: selectedCategoryId)
                                viewModel.isLoading = false
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding(.top, 4)
            
            TabView(selection: $viewModel.selectedCategoryId) {
                ForEach(dummyCategories, id: \.id) {category in
                    ScrollView(.vertical){
                        
                        if viewModel.isLoading {
                            VStack {
                                ForEach(0..<6, id: \.self) { _ in
                                    SkeletonNewsCard()
                                }
                            }
                            .padding(.horizontal, 12)
                            
                        } else {
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
                    .tag(category)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: viewModel.selectedCategoryId){ _, newCategoryId in
                viewModel.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    viewModel.updateArticles(category: newCategoryId)
                    viewModel.isLoading = false
                }
            }
        }
        .safeAreaInset(edge: .top){
            CustomAppBar()
                
        }

        .onAppear {
            let isPresentHomeModal = UserDefaults.standard.bool(forKey: UserDefaultsKey.isShowHomeModal)
            if isPresentHomeModal == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    router.present(fullScreenCover: .reliabilityRateInfoModal)
                }
            }
            
            // simulating fetch loading
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //                viewModel.updateArticles(category: viewModel.selectedCategoryId)
            //                viewModel.isLoading = false
            //            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    AppRouterView(previewPage: .newsList(category: "breaking"))
    
}
