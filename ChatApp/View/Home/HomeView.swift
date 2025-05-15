//
//  ContentView.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    Text(viewModel.animatedText)
                        .font(.title)
                    
                    Spacer()

                    ButtonView(title: "Register") {
                        viewModel.navigateToLoginRegister(isLogin: false)
                    }
                    ButtonView(title: "Login") {
                        viewModel.navigateToLoginRegister(isLogin: true)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.animateText()
        }
    }
}

struct ButtonView: View {
    var title: String
    var onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .font(.title3)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(12)
        }
        .padding(.horizontal, 12)
    }
}
