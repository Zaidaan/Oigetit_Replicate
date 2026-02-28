//
//  ArticleResponse.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

struct ArticleResponse: Decodable {
    var status: String
    var articles: [Article]
}
