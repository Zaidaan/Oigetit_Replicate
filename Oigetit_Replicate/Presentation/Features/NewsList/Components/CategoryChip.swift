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
    let handleSelection: (String) -> Void
    private var isSelected: Bool {
        selectedCategoryId == newsCategory.id
    }
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: newsCategory.topicIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 30)
                .foregroundStyle(Color.black.opacity(0.3))
                .fontWeight(Font.Weight.ultraLight)
            Text(newsCategory.topicTitle)
                .font(.system(size: 11, weight: .regular))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 4)
                
        }
        .frame(width: 70, height: 60)
        .background(isSelected ? ColorSet.blue.opacity(0.6) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            selectedCategoryId = newsCategory.id
            handleSelection(selectedCategoryId)
        }
    }
}


