//
//  ChatService.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import API

enum MessageSender: String, Codable {
    case user
    case assistant
}

func mockMessages() -> [Message] {
    [
        .init(sender: .assistant, content: "Give me info about last receip"),
        
        .init(sender: .user, content: "Sure! Last time u spend 150MDL at SRL Linella, u bought milk, bread, bear, and meat")
    ]
}

struct Message: Identifiable, Codable {
    let id: UUID
    let sender: MessageSender
    let content: String
    let timestamp: Date
    
    init(id: UUID = UUID(), sender: MessageSender, content: String, timestamp: Date = Date()) {
        self.id = id
        self.sender = sender
        self.content = content
        self.timestamp = timestamp
    }
}

@MainActor
final class ChatService: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        Task {
            do {
                try await DefaultAPI.getChat(userId: "550e8400-e29b-41d4-a716-446655440000")
            }
        }
    }
    
    func sendMessage(text: String) {
        // Добавляем сообщение пользователя
        let userMessage = Message(sender: .user, content: text)
        messages.append(userMessage)
        
        isLoading = true
        errorMessage = nil
        
        
        Task {
            print("started messaging")
            do {
                let response = try await DefaultAPI.sendMessage(userId: "550e8400-e29b-41d4-a716-446655440000", chatMessageDto: .init(message: text))
                print(response)
                if let error = response.error {
                    errorMessage = "Ошибка: \(error)"
                } else  {
                    let assistantMessage = Message(sender: .assistant, content: response.data?.response ?? "")
                    messages.append(assistantMessage)
                }
            } catch {
                errorMessage = "Ошибка: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    func clearAll() {
        messages.removeAll()
        errorMessage = nil
    }
}
