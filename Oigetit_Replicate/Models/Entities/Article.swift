//
//  News.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Foundation

struct Article: Identifiable, Decodable {
    var id: String
    var title: String
    var thumbnail: String
    var categories: [String]
    var publishedAt: String
    var publisher: String
    var score: NewsScore
}
