//
//  InputField.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import SwiftUI
import NoughtyUI

struct MessageComposerView: View {
    @Binding var text: String
    var onCommit: () -> ()

    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass.circle.fill")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color(hex: "#7E5A9B"))
                .frame(width: 28, height: 28)
              //  .background(Theme.gradient)
                .cornerRadius(6)
                .padding(.leading, 10)
            
            
            TextField("Search...", text: $text) {
                onCommit()
            }
                .contentShape(Rectangle())
                .lineLimit(5)
                .foregroundStyle(Color.black)
                .padding(.vertical, 10)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color(hex: "#18396B0D").opacity(0.07), radius: 2, x: 2)
        .shadow(color: Color(hex: "#18396B0D").opacity(0.07), radius: 2, x: -2)

    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.red, lineWidth: 3)
        ).padding()
    }
}

#Preview {
    MainView()
}
