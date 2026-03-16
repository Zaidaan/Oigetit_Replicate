//
//  ArticleCommentSheet.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 16/03/26.
//

import SwiftUI

struct ArticleCommentSheet: View {
    
    @State var commentCount: Int = 0
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 12){
                Text("Comment")
                    .font(.title.bold())
                Text("\(commentCount)")
                    .foregroundStyle(Color.gray)
                Spacer()
            }
        }
        .padding(16)
        .safeAreaInset(edge: .bottom) {
            VStack {
                Spacer()
                HStack{
                    HStack(spacing: 16){
                        Image(systemName: IconSet.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .fontWeight(.light)
                            .foregroundStyle(Color.black)
                        
                        TextField("Comment", text: .constant(""))
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Spacer()
                    
                    Button(
                        action: {},
                        label: {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundStyle(ColorSet.blueButton)
                        }
                    )
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 0.5)
                )
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview{
    @Previewable @State var isPresented: Bool = true
    
    VStack{
        
    }
    .sheet(isPresented: $isPresented) {
        ArticleCommentSheet()
            .presentationDetents([.fraction(0.5)])
            .presentationCornerRadius(16)
    }
}
