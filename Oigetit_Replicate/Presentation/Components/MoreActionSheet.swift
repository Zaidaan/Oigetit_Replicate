//
//  MoreActionSheet.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 16/03/26.
//

import SwiftUI

struct MoreActionSheet: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: AppRouter
    
    @State var isShowRateInfo: Bool = false
    let article: Article
    
    var body: some View {
        VStack{
            HStack{
                Text(article.categories[0])
                    .font(.title3.bold())
                Spacer()
                
                Button(
                    action: {},
                    label: {
                        Text("- Unfollow")
                            .font(.title3)
                            .foregroundStyle(Color.gray)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                )
            }
            
            Spacer()
            
            Divider()
            
            Spacer()
            
            VStack(spacing: 24){
                ShareLink(item: article.title){
                    HStack(spacing: 24){
                        Image(systemName: IconSet.shareGlobe)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18 ,height: 18)
                        Text("Share")
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .foregroundStyle(colorScheme == .light ? .black : .white)
                
                Button(
                    action: {},
                    label: {
                        HStack(spacing: 24) {
                            Image(systemName: IconSet.saveForLater)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                            Text("Save for Later")
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                )
                .foregroundStyle(colorScheme == .light ? .black : .white)
                
                Button(
                    action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            isShowRateInfo = true
                        }
                    },
                    label: {
                        HStack(spacing: 24) {
                            Image(systemName: IconSet.shieldFill)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 17)
                            Text("How We Rate News")
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                )
                .foregroundStyle(colorScheme == .light ? .black : .white)
                
                Button(
                    action: {},
                    label: {
                        HStack(spacing: 24) {
                            Image(systemName: IconSet.reportIssue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18 ,height: 18)
                            Text("Report an Issue")
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                )
                .foregroundStyle(colorScheme == .light ? .black : .white)
            }
            
            Spacer()
            
            Divider()
            
            Spacer()
            
            Button(
                action: {
                    router.dismissSheet()
                },
                label: {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.medium)
                }
            )
            .foregroundStyle(colorScheme == .light ? .black : .white)
            
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 28)
        .ignoresSafeArea(edges: .bottom)
        .fullScreenCover(isPresented: $isShowRateInfo) {
            ReliabilityRateInfoModal()
                .presentationBackground(.clear)
        }
    }
}


