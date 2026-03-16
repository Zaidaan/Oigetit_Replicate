//
//  NewsCategory.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Foundation

struct NewsCategory: Hashable, Identifiable {
    var topicTitle: String
    var topicIcon: String
    
    var id: String {
        var firstWord: String = topicTitle
        
        if let firstSpaceIndex = topicTitle.firstIndex(of: " ") {
            firstWord = String(topicTitle[..<firstSpaceIndex])
        }
        
        return firstWord.lowercased()
    }
}
