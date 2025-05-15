import SwiftUI
import FirebaseAuth

struct ChatView: View {
    
    @StateObject var chatViewModel: ChatViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    ScrollViewReader { scrollViewProxy in
                        ScrollView {
                            LazyVStack {
                                ForEach(chatViewModel.messages) { message in
                                    HStack {
                                        if message.sender != Auth.auth().currentUser?.email {
                                            ProfileIconView(title: "You")
                                        }
                                        Text(message.text)
                                            .padding(10)
                                            .background(message.sender != Auth.auth().currentUser?.email ? Color.yellow : Color.yellow.opacity(0.2))
                                            .cornerRadius(8)
                                            .frame(maxWidth: .infinity, alignment: message.sender != Auth.auth().currentUser?.email ? .leading : .trailing)
                                        if message.sender == Auth.auth().currentUser?.email {
                                            ProfileIconView(title: "Me")
                                        }
                                    }
                                    .id(message.id)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .onChange(of: chatViewModel.messages.count) { _ in
                            if let lastMessage = chatViewModel.messages.last {
                                withAnimation {
                                    scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                
                HStack {
                    TextField("Type...", text: $chatViewModel.messageText)
                        .padding(.leading, 12)
                        .frame(height: 44)
                        .background(Color.white)
                        .foregroundColor(.black)
                    Button {
                        chatViewModel.sendMessage()
                    } label: {
                        Text("Send")
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.leading, 12)
                .frame(height: 80)
                .background(.yellow)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Chat")
                        .font(.title)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Out") {
                        chatViewModel.logOut()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            chatViewModel.loadMessage()
        }
    }
}


struct ProfileIconView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(12)
            .background(Circle().fill(Color.yellow.opacity(0.5)))
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
