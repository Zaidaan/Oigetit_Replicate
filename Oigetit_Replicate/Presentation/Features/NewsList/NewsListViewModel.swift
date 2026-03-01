//
//  NewsListViewModel.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Combine
import Foundation
import Network


class NewsListViewModel: ObservableObject {
    @Published var selectedCategoryId: String = "breaking"
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = true
    
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.Oigetit-Replicate.networkQueue")
    @Published var isConnected: Bool = true
    
    init(category: String) {
        checkInternetConnection()
        updateArticles(category: category)
        print(articles)
    }
    
    func checkInternetConnection() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: queue)
    }
    
    func updateArticles(category: String) {
        if isConnected {
            self.articles = ArticleUseCaseImpl(with: category).articles
//            isLoading = false
        } else {
            print("There is no internet connection, can't update article")
            // some handler, maybe use caching logic
        }
        
    }
    
    
}
