//
//  NavigationManager.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable {
    case home
    case loginRegister(isLogin: Bool)
    case chat
}

final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
