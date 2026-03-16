//
//  Skeleton.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 01/03/26.
//

import SwiftUI

struct SkeletonNewsCard: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isPulsing: Bool = false
    
    var body: some View {
        VStack(spacing: 12){
            HStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 50)
                RoundedRectangle(cornerRadius: 4)
                    .aspectRatio(5/4, contentMode: .fit)
                    .frame(height: 120)
            }
            .foregroundStyle(Color.gray.opacity(0.2))
            
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 100, height: 16)
                Spacer()
            }
            .foregroundStyle(Color.gray.opacity(0.2))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(colorScheme == .light ? ColorSet.white.opacity(0.5) : ColorSet.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .opacity(isPulsing ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isPulsing)
        .onAppear {
            isPulsing = true
        }
    }
}


#Preview {
    SkeletonNewsCard()
}
