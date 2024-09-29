//
//  EntryScreen.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import SwiftUI
import UIKit
import Foundation

struct EntryScreen: View {
    var onLogin: () -> ()
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.clear)
                .frame(maxWidth: 110, maxHeight: 110)
                .overlay {
                    Image(.owl)
                        .resizable()
                }
                .padding(.top, 81)
            
            Text("ShopUsor")
                .font(.system(size: 32))
                .bold()
            
            //Facebook
            Button {
                onLogin()
            } label: {
                HStack  {
                    Image(.fb)
                        .resizable()
                        .frame(maxWidth: 24, maxHeight: 24)
                        .padding(.vertical, 16)
                    
                    Text("Sign in with Facebook")
                        .foregroundStyle(Color.royalPurple)
                        .font(.system(size: 16))
                        .bold()
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.mimiPink)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top, 130)
            }
            
            HStack {
                Button {
                    onLogin()
                } label: {
                    Image(.google)
                        .resizable()
                        .frame(maxWidth: 24, maxHeight: 24)
                        .padding(.horizontal, 63)
                        .padding(.vertical, 16)
                        .background(Color.mimiPink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Spacer()
                
                Button {
                    onLogin()
                } label: {
                    Image(.apple)
                        .resizable()
                        .frame(maxWidth: 24, maxHeight: 24)
                        .padding(.horizontal, 63)
                        .padding(.vertical, 16)
                        .background(Color.mimiPink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            Button {
                //do something
            } label: {
                Text("Don't have an account? Sign In")
                    .foregroundStyle(.black)
                    .font(.system(size: 14))
                    .fontWeight(.light)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 35)
        .background(.white)
    }
}

#Preview {
    EntryScreen() {}
}
