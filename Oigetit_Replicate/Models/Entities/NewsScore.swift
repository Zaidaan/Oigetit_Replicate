//
//  NewsScore.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import Foundation

struct NewsScore: Identifiable, Decodable, Hashable {
    var id: UUID = UUID()
    var reliability: Int
    var sentiment: String
    
    enum CodingKeys : String, CodingKey {
        case reliability
        case sentiment
    }
}
