//
//  AppRouter.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI
import Combine

enum Page: Hashable, Identifiable {
    case newsList(category: String)
    case articleDetail(article: Article)
    
    var id: String {
        switch self {
        case .newsList: return "News List"
        case .articleDetail: return "News Detail"
        }
    }
}

class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: Page){
        path.append(page)
    }
    
    func pushReplacement(_ page: Page){
        path = NavigationPath()
        path.append(page)
    }
    
    func pop(){
        if path.isEmpty { return } else {path.removeLast()}
    }
    
    func popToRoot(){
        path.removeLast(path.count)
        path.append(Page.newsList(category: "breaking"))
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .newsList(let category):
            NewsListView(category: category)
        case .articleDetail(let article):
            ArticleDetailView(article: article)
        }
    }
}
