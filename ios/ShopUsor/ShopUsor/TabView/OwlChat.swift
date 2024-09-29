//
//  OwlChat.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import SwiftUI
import API

struct MessageComposerChat: View {
    @Binding var text: String
    var onCommit: () -> ()

    var body: some View {
        HStack(spacing: 0) {
            //            Image(systemName: "magnifyingglass.circle.fill")
            //                .font(.system(size: 16, weight: .bold))
            //                .foregroundStyle(Color(hex: "#7E5A9B"))
            //                .frame(width: 28, height: 28)
            //              //  .background(Theme.gradient)
            //                .cornerRadius(6)
            //                .padding(.leading, 10)
            
            
            TextField("Message...", text: $text) {
                onCommit()
                text = ""
            }
            .contentShape(Rectangle())
            .lineLimit(5)
            .foregroundStyle(Color.black)
            .padding(.vertical, 10)
            .padding(.leading, 5)
        }
        .overlay(alignment: .trailing, content: {
            Image(.micro)
                .padding(.trailing, 15)
        })
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(hex: "#18396B0D").opacity(0.07), radius: 2, x: 2)
        .shadow(color: Color(hex: "#18396B0D").opacity(0.07), radius: 2, x: -2)
    }
}

struct OwlChat: View {
    @StateObject var chatService = ChatService()
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 25) {
            ForEach(chatService.messages) { message in
                MessageView(message: message.content, isCurrentUser: message.sender == .user)
            }
            
            Spacer()
            
            MessageComposerChat(text: $text) {
                chatService.sendMessage(text: text)
                text = ""
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Owl chat")
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    OwlChat()
}

struct MessageBubbleView: View {
    let message: String
    let isCurrentUser: Bool

    init(message: String, isCurrentUser: Bool) {
        self.message = message
        self.isCurrentUser = isCurrentUser
        self.radii = .init(
            topLeading: 18,
            bottomLeading: !isCurrentUser ? 18 : 0,
            bottomTrailing: isCurrentUser ? 18 : 0,
            topTrailing: 18
        )
    }

    let radii: RectangleCornerRadii

    var body: some View {
        VStack(alignment: .leading) {
            Text(message)
                //.font(Theme.messageFont)
                .foregroundStyle( isCurrentUser ? Color.black : Color.white)
                .layoutPriority(1)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            isCurrentUser ? Color.teaRose : Color.veronica
        )
        .clipShape(
            UnevenRoundedRectangle(
                cornerRadii: radii,
                style: .continuous
            )
        )
        .contentShape(Rectangle())
    }
}

struct MessageView: View {
    let message: String
    var isCurrentUser: Bool

    var body: some View {
        MessageBubbleView(message: message, isCurrentUser: isCurrentUser)
        .frame(maxWidth: .infinity, alignment: isCurrentUser ? .leading : .trailing)
    }
}
