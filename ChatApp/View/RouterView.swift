//
//  RouterView.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/15/25.
//

import SwiftUI

struct RouterView: View {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            HomeView(viewModel: HomeViewModel(navigationManager: navigationManager))
                .environmentObject(navigationManager)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .home:
                        HomeView(viewModel: HomeViewModel(navigationManager: navigationManager))
                            .environmentObject(navigationManager)
                    case .loginRegister(let isLogin):
                        LoginRegisterView(
                            viewModel: LoginRegisterViewModel(isLogin: isLogin, navigationManager: navigationManager)
                        )
                        .environmentObject(navigationManager)
                    case .chat:
                        ChatView(chatViewModel: ChatViewModel(navigationManager: navigationManager))
                            .environmentObject(navigationManager)
                    }
                }
        }
        .environmentObject(navigationManager)
    }
}


#Preview {
    RouterView()
}
