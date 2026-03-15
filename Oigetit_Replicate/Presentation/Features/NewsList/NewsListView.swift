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
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .safeAreaInset(edge: .top){
            CustomAppBar()
                
        }
        .fullScreenCover(isPresented: $viewModel.isShowModal) {
            RateInfoModal(isShowModal: $viewModel.isShowModal)
            .presentationBackground(.clear)
        }

        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    viewModel.isShowModal = UserDefaults.standard.bool(forKey: UserDefaultsKey.isShowHomeModal)
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
