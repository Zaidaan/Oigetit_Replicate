//
//  CategoryChip.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct CategoryChip: View {
    let newsCategory: NewsCategory
    @Binding var selectedCategoryId: String
    let completion: (String) -> Void
    private var isSelected: Bool {
        selectedCategoryId == newsCategory.id
    }
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: newsCategory.topicIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.black.opacity(0.3))
            Text(newsCategory.topicTitle)
                .font(.system(size: 11, weight: .regular))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(width: .infinity)
                .padding(.horizontal, 4)
                
        }
        .frame(width: 70, height: 60)
        .background(isSelected ? Color.blue.opacity(0.6) : Color.white) // don't forget to change the color
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            selectedCategoryId = newsCategory.id
            completion(selectedCategoryId)
        }
    }
}

