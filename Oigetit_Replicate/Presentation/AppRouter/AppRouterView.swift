//
//  AppRouterView.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//

import SwiftUI

struct AppRouterView: View {
    @StateObject private var router =  AppRouter()
    
    private var previewPage: Page?
    
    init(previewPage: Page? = nil){
        self.previewPage = previewPage
    }
    
    var body: some View {
        NavigationStack(path: $router.path){
            router.build(page: previewPage ?? .newsList(category: "breaking"))
                .navigationDestination(for: Page.self) {page in
                    router.build(page: page)
                }
                .toolbarBackground(Color.blue.opacity(0.7), for: .navigationBar)
                .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        }
        .environmentObject(router)
        .preferredColorScheme(ColorScheme.light)
    }
}
