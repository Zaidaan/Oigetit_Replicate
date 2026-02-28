//
//  Constant.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

enum Sentiment {
    case positive
    case neutral
    case negative
    
    var description: String {
        switch self {
        case .positive:
            return "The author of the article had a positive attitude towards the topic"
        case .neutral:
            return "The author of the article had a neutral attitude towards the topic"
        case .negative:
            return "The author of the article had a negative attitude towards the topic"
        }
    }
    
    var color: Color {
        switch self {
        case .positive:
            return .green
        case .neutral:
            return .orange
        case .negative:
            return .red
        }
    }
    
    var icon: String {
        switch self{
        case .positive:
            return "face.smiling"
        case .neutral:
            return "face.smiling"
        case .negative:
            return "face.smiling"
        }
    }
}
