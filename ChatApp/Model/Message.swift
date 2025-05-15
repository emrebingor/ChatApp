//
//  Message.swift
//  ChatApp
//
//  Created by Emre Bingor on 5/14/25.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let text: String
}
