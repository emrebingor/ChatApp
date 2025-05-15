//
//  LoginRegisterViewModel.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import Foundation
import FirebaseAuth

final class LoginRegisterViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var navigatePage: Bool = false
    @Published var isLogin: Bool
    @Published var showAlert: Bool = false
    
    private let navigationManager: NavigationManager
    
    init(isLogin: Bool, navigationManager: NavigationManager) {
        self.isLogin = isLogin
        self.navigationManager = navigationManager
    }
    
    func loginStatusUpdate() {
        isLogin = !isLogin
    }
    
    func register() {
        Auth.auth().createUser(withEmail: emailText, password: password) { result, error in
            if let e = error {
                self.errorMessage = "Wrong mail address or password. Please try again."
                self.showAlert = true
            } else {
                DispatchQueue.main.async {
                    self.emailText = ""
                    self.password = ""
                    self.navigationManager.push(.chat)
                }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: emailText, password: password) { authResult, error in
            if let e = error {
                self.errorMessage = "Wrong mail address or password. Please try again."
                self.showAlert = true
            } else {
                DispatchQueue.main.async {
                    self.emailText = ""
                    self.password = ""
                    self.navigationManager.push(.chat)
                }
            }
        }
    }
}
