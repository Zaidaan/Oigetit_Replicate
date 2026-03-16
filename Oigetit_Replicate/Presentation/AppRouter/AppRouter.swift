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

enum Sheet: Hashable, Identifiable {
    case articleCommentSheet
    case moreActionSheet(article: Article)
    
    var id: String {
        switch self {
        case .articleCommentSheet: return "Article Comment Sheet"
        case .moreActionSheet: return "More Action Sheet"
        }
    }
}

enum FullScreenCover: Hashable, Identifiable{
    case reliabilityRateInfoModal
    case sentimentRateInfoModal
    case reliabilityModal(score: Int)
    
    var id: String {
        switch self {
        case .reliabilityRateInfoModal: return "Reliability Rate Info Modal"
        case .sentimentRateInfoModal: return "Sentiment Rate Info Modal"
        case .reliabilityModal: return "Reliability Rate Modal"
        }
    }
}

class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var detents: Set<PresentationDetent>?
    @Published var fullScreenCover: FullScreenCover?
    @Published var isPresentFullScreenCover: Bool = false
    
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
    
    func present(sheet: Sheet, detents: Set<PresentationDetent>) {
        self.sheet = sheet
        self.detents = detents
    }
    
    func present(fullScreenCover: FullScreenCover) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction){
            self.fullScreenCover = fullScreenCover
        }
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction){
            self.fullScreenCover = nil
        }
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
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .articleCommentSheet:
            ArticleCommentSheet()
        case .moreActionSheet(let article):
            MoreActionSheet(article: article)
        }
            
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .reliabilityRateInfoModal:
            ReliabilityRateInfoModal()
        case .sentimentRateInfoModal:
            SentimentRateInfoModal()
        case .reliabilityModal(let score):
            ReliabilityModal(score: score)
        }
    }
}
