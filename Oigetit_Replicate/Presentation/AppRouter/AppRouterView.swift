//
//  AppRouterView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct AppRouterView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var router = AppRouter()
    
    @AppStorage("isDarkModeOn") var isDarkModeOn: Bool = false
    
    private var previewPage: Page?
    
    init(previewPage: Page? = nil){
        self.previewPage = previewPage
    }
    
    var body: some View {
        NavigationStack(path: $router.path){
            router.build(page: previewPage ?? .newsList(category: "breaking"))
                .navigationDestination(for: Page.self) { page in
                    router.build(page: page)
                        .background(colorScheme == .light ? ColorSet.gray : ColorSet.backgroundGray)
                }
                .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                .background(colorScheme == .light ? ColorSet.gray : ColorSet.backgroundGray)
            
                .sheet(item: $router.sheet){ sheet in
                    router.build(sheet: sheet)
                        .presentationDetents(router.detents ?? [])
                        .presentationCornerRadius(16)
                        .presentationDragIndicator(.hidden)
                        .presentationBackground(ColorSet.white)
                }
                .fullScreenCover(item: $router.fullScreenCover){ fullScreenCover in
                    router.build(fullScreenCover: fullScreenCover)
                        .presentationBackground(.clear)
                }
                
        }
        .environmentObject(router)
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}
