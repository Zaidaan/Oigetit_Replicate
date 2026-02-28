//
//  ArticleDetailViewModel.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Combine
import SwiftUI

class ArticleDetailViewModel: ObservableObject {
    @Published var article: Article
    @Published var content: String = ""
    @Published var hasMediaLoaded: Bool = false
    @Published var isMediaVisible: Bool = true
    
    init(article: Article) {
        self.article = article
    }
    
    func fetchContent(url: String = "") async -> String {
        if let endpoint = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: endpoint)
                /*
                 let decodedData = try JSONDecoder().decode(Content.self, from: data)
                 DispatchQueue.main.async{
                    content = decodedData
                 }
                 */
            }
            catch {
                print("Failed to fetch content from the given URL")
            }
            
            
        } else {
            content = """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                
                Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                
                Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris.
                """
        }
        
        
        return content
    }
}
