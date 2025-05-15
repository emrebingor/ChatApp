//
//  NavigationManager.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import Foundation

class AppState: ObservableObject {
    enum Screen {
        case home
        case login
        case chat
    }

    @Published var currentScreen: Screen = .home
}
