//
//  NewsListViewModel.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Combine
import Foundation


class NewsListViewModel: ObservableObject {
    @Published var selectedCategoryId: String = "breaking"
    @Published var articles: [Article] = []
    
    init(category: String) {
        self.articles = ArticleUseCaseImpl(with: category).articles
        print(articles)
    }
    
    func updateArticles(category: String) {
        self.articles = ArticleUseCaseImpl(with: category).articles
    }
    
    
}
