//
//  Sentiment.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 14/03/26.
//

import SwiftUI

func identifySentiment(sentiment: String) -> Sentiment {
    switch sentiment {
    case "positive":
        return .positive
    case "neutral":
        return .neutral
    case "negative":
        return .negative
    default:
        return .neutral
    }
}

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
            return ColorSet.green
        case .neutral:
            return ColorSet.orange
        case .negative:
            return ColorSet.red
        }
    }
    
    var icon: String {
        switch self{
        case .positive:
            return IconSet.faceSmiling
        case .neutral:
            return IconSet.faceNeutral
        case .negative:
            return IconSet.faceSad
        }
    }
}
