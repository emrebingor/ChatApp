//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class ChatViewModel: ObservableObject {
    
    @Published var messageText: String = ""
    @Published var messages: [Message] = []
    private var navigationManager: NavigationManager
    
    let db = Firestore.firestore()
    
    init(navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.navigationManager.popToRoot()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @MainActor
    func loadMessage() {
        Task {
            db.collection("messages").order(by: "date").addSnapshotListener { querySnapshot, error in
                self.messages = []

                if let error = error {
                    print("Error listening for changes: \(error)")
                    return
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data["sender"] as? String, let text = data["text"] as? String {
                                self.messages.append(Message(sender: sender, text: text))
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    @MainActor
    func sendMessage() {
        let message = messageText
        let sender = Auth.auth().currentUser?.email
        
        if let sender = sender, !message.isEmpty {
            Task {
                do {
                    try await db.collection("messages").addDocument(data: ["sender": sender, "text": message, "date": Date().timeIntervalSince1970])
                    self.messageText = ""
                } catch {
                    print("Error adding document: \(error)")
                }
            }
        }
    }
}
