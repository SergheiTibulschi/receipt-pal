//
//  SettingsScreen.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import SwiftUI
import NoughtyUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(maxWidth: 9, maxHeight: 16)
                .foregroundStyle(Color(hex: "#63458A"))
                .padding(.vertical, 6)
                .padding(.horizontal, 9)
                .background(Color(hex: "#EDD2E0"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct SettingsScreen: View {
    
    var body: some View {
        VStack(spacing: 12  ) {
            
            createButton(image: .profile, text: "Manage profile", onTap: {})
                .padding(.top, 29)
            createButton(image: .push, text: "Push notifications", onTap: {})
            createButton(image: .support, text: "Support", onTap: {})
            createButton(image: .eraseData, text: "Erase data and Purchase History", onTap: {})
                .padding(.top, 54)
            createButton(image: .logout, text: "Logout", onTap: {})
            createButton(image: .deleteProfile, text: "Delete", onTap: {})
            
        }
        .padding(.horizontal, 25)
        .navigationTitle("ShopUsor")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
    }
    
    func createButton(image: ImageResource, text: String, onTap: @escaping () -> ()) -> some View {
        Button {
            onTap()
        } label: {
            HStack {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(image == .deleteProfile ? .red : .black)                    .frame(maxWidth: 20, maxHeight: 20)
                
                Text(text)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 18)
            .padding(.vertical, 16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(hex: "#18396B0D").opacity(0.05), radius: 2, x: 2)
            .shadow(color: Color(hex: "#18396B0D").opacity(0.05), radius: 2, x: -2)
        }
    }
    
}

#Preview {
    BackButton()
}
