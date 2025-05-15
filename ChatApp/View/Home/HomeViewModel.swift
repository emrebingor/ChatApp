//
//  HomeViewModel.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import Foundation
import UIKit

final class HomeViewModel: ObservableObject {
    let textToType = "ChatAPP 💬"
    @Published var animatedText: String = ""
    private let navigationManager: NavigationManager
    
    init(navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
    }
    
    func navigateToLoginRegister(isLogin: Bool) {
        DispatchQueue.main.async {
            self.animatedText = ""
        }
        navigationManager.push(.loginRegister(isLogin: isLogin))
    }
        
    func animateText() {
        for (index, character) in textToType.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                self.animatedText.append(character)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
    }
}
