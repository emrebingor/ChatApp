//
//  LoginRegisterView.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import SwiftUI

struct LoginRegisterView: View {
    
    @StateObject var viewModel: LoginRegisterViewModel
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(viewModel.isLogin ? "Login" : "Register")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                
                TextField("Email", text: $viewModel.emailText)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .submitLabel(.done)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .submitLabel(.done)
                
                Button {
                    viewModel.loginStatusUpdate()
                } label: {
                    Text(viewModel.isLogin ? "Don't have an account?" : "Already have an account?")
                }
                
                Spacer()
                
                Button() {
                    viewModel.isLogin ? viewModel.login() : viewModel.register()
                } label: {
                    Text(viewModel.isLogin ? "Login" : "Register")
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) {
            Button("Okay", role: .cancel) {
                viewModel.showAlert = false
            }
        }
    }
}
