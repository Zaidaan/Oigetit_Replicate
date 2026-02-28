//
//  ArticleUseCase.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Foundation

protocol ArticleUseCase {
    func decodeNewsResponse(from jsonString: String) throws -> (status: String, articles: [Article])
    func fetchArticles(with category: String) -> [Article]
}

class ArticleUseCaseImpl: ArticleUseCase {
    
    var articles: [Article] = []
    
    init (with category: String) {
        self.articles = self.fetchArticles(with: category)
    }
    
    internal func fetchArticles(with category: String) -> [Article] {
        let endpoint = dummyNews // later use real endpoint
        
        var articles: [Article] = []
        
        do {
            let data = try decodeNewsResponse(from: endpoint)
            let newArticles: [Article] = data.articles.filter { article in
                article.categories.contains { categoryInArray in
                    categoryInArray.lowercased() == category.lowercased()
                }
            }
            articles = newArticles.sorted { $0.publishedAt > $1.publishedAt }
            
        } catch {
            print("Failed to decode News: \(error)")
        }
        
        return articles
    }
    
    internal func decodeNewsResponse(from jsonString: String) throws -> (status: String, articles: [Article]) {
        
        let cleaned = jsonString
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard cleaned.first == "{" else {
            throw NSError(domain: "Invalid JSON Format", code: -2, userInfo: [NSLocalizedDescriptionKey: "JSON does not start with '{'"])
        }
        
        guard let jsonData = cleaned.data(using: .utf8) else {
            throw NSError(domain: "Encoding Error", code: -1, userInfo: nil)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(ArticleResponse.self, from: jsonData)
        
        return (response.status, response.articles)
    }
    
    
}
